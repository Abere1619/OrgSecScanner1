#!/bin/bash
# Discovery Module - Network Device Discovery

# Get base directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Load configuration
source "$BASE_DIR/config/settings.conf"

# Main discovery function
discover_network() {
    local network="$1"
    local timestamp
    timestamp=$(date '+%Y%m%d_%H%M%S')
    local scan_dir="$BASE_DIR/data/discovery_$timestamp"
    
    mkdir -p "$scan_dir"
    
    echo -e "${BLUE}[DISCOVERY] Scanning network: $network${NC}"
    
    # Host Discovery
    echo -e "\n${GREEN}[PHASE 1] Host Discovery${NC}"
    echo -e "${BLUE}[HOSTS] Discovering active hosts...${NC}"
    
    nmap -sn "$network" -oA "$scan_dir/host_discovery" > /dev/null
    
    # Extract active hosts
    grep "Nmap scan report" "$scan_dir/host_discovery.nmap" | awk '{print $5, $6}' > "$scan_dir/hosts.txt"
    
    local host_count
    host_count=$(grep -c "Host is up" "$scan_dir/host_discovery.nmap")
    echo -e "${GREEN}[HOSTS] Found $host_count active devices${NC}"
    
    # Show discovered hosts
    echo -e "\n${YELLOW}Discovered Hosts:${NC}"
    cat "$scan_dir/hosts.txt"
    
    # Service Detection
    echo -e "\n${GREEN}[PHASE 2] Service Detection${NC}"
    echo -e "${BLUE}[SERVICES] Detecting services...${NC}"
    
    # Get just the IP addresses
    awk '{print $1}' "$scan_dir/hosts.txt" > "$scan_dir/hosts_ips.txt"
    
    # Quick service scan
    nmap -F -T4 -iL "$scan_dir/hosts_ips.txt" -oA "$scan_dir/service_scan" > /dev/null
    
    echo -e "${GREEN}[SERVICES] Service detection completed${NC}"
    
    # Generate simple report
    generate_discovery_report "$scan_dir"
}

# Generate discovery report
generate_discovery_report() {
    local scan_dir="$1"
    local report_file="$BASE_DIR/reports/discovery_report_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "NETWORK DISCOVERY REPORT"
        echo "========================"
        echo "Scan Date: $(date)"
        echo "Network: $DEFAULT_NETWORK"
        echo ""
        
        echo "DISCOVERED HOSTS:"
        echo "----------------"
        cat "$scan_dir/hosts.txt"
        echo ""
        
        echo "SERVICES FOUND:"
        echo "--------------"
        grep "open" "$scan_dir/service_scan.nmap" | head -20
        
    } > "$report_file"
    
    echo -e "${GREEN}[REPORT] Discovery report generated: $report_file${NC}"
}

# Enhanced external network discovery
discover_external_network() {
    local network="$1"
    local timestamp
    timestamp=$(date '+%Y%m%d_%H%M%S')
    local scan_dir="$BASE_DIR/data/external_$timestamp"
    
    mkdir -p "$scan_dir"
    
    echo -e "${BLUE}[EXTERNAL] Scanning external network: $network${NC}"
    echo -e "${YELLOW}⚠️  Legal Notice: Ensure you have permission to scan this network${NC}"
    
    # External scanning with appropriate timing
    nmap -T2 -sn "$network" -oA "$scan_dir/external_host_discovery" > /dev/null
    
    # Get discovered hosts
    grep "Nmap scan report" "$scan_dir/external_host_discovery.nmap" | awk '{print $5, $6}' > "$scan_dir/external_hosts.txt"
    
    local host_count
    host_count=$(wc -l < "$scan_dir/external_hosts.txt")
    echo -e "${GREEN}[EXTERNAL] Found $host_count external hosts${NC}"
    
    # Service detection on found hosts
    if [ "$host_count" -gt 0 ]; then
        echo -e "${BLUE}[EXTERNAL] Detecting services on external hosts...${NC}"
        awk '{print $1}' "$scan_dir/external_hosts.txt" > "$scan_dir/external_hosts_ips.txt"
        nmap -T2 -F -iL "$scan_dir/external_hosts_ips.txt" -oA "$scan_dir/external_service_scan" > /dev/null
    fi
    
    generate_external_report "$scan_dir" "$network"
}

# Generate external scan report
generate_external_report() {
    local scan_dir="$1"
    local network="$2"
    local report_file="$BASE_DIR/reports/external_report_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "EXTERNAL NETWORK DISCOVERY REPORT"
        echo "================================="
        echo "Scan Date: $(date)"
        echo "Target Network: $network"
        echo "Scan Type: External"
        echo "Legal Notice: Ensure proper authorization for scanning"
        echo ""
        
        echo "DISCOVERED HOSTS:"
        echo "----------------"
        if [ -f "$scan_dir/external_hosts.txt" ]; then
            cat "$scan_dir/external_hosts.txt"
        else
            echo "No hosts discovered"
        fi
        echo ""
        
        echo "SERVICES FOUND:"
        echo "--------------"
        if [ -f "$scan_dir/external_service_scan.nmap" ]; then
            grep "open" "$scan_dir/external_service_scan.nmap" | head -20
        fi
        echo ""
        
        echo "SECURITY NOTES:"
        echo "--------------"
        echo "- Port 53/tcp: DNS service (common for name servers)"
        echo "- Port 443/tcp: HTTPS web service (common for management)"
        echo "- These are expected services for a public DNS server"
        echo ""
        
        echo "RECOMMENDATIONS:"
        echo "---------------"
        echo "1. Verify scanning authorization for external networks"
        echo "2. Use non-intrusive scan timing for external targets"
        echo "3. Document all scanning activities"
        echo "4. Respect rate limits and scanning policies"
        
    } > "$report_file"
    
    echo -e "${GREEN}[REPORT] External scan report generated: $report_file${NC}"
}
