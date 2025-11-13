#!/bin/bash
# Assessment Module - Security Vulnerability Assessment

# Get base directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Load configuration
source "$BASE_DIR/config/settings.conf"

# Main assessment function
assess_security() {
    local target="${1:-all}"
    local timestamp
    timestamp=$(date '+%Y%m%d_%H%M%S')
    local assessment_dir="$BASE_DIR/data/assessment_$timestamp"
    
    mkdir -p "$assessment_dir"
    
    echo -e "${BLUE}[ASSESSMENT] Starting security assessment${NC}"
    
    if [ "$target" = "all" ]; then
        assess_critical_infrastructure "$assessment_dir"
    else
        assess_single_device "$target" "$assessment_dir"
    fi
}

# Assess critical infrastructure
assess_critical_infrastructure() {
    local assessment_dir="$1"
    
    echo -e "\n${YELLOW}[CRITICAL] Assessing network infrastructure${NC}"
    
    for host in "${CRITICAL_HOSTS[@]}"; do
        echo -e "${BLUE}[SCANNING] $host${NC}"
        assess_network_device "$host" "$assessment_dir"
    done
}

# Assess a single network device
assess_network_device() {
    local host="$1"
    local assessment_dir="$2"
    
    local host_dir="$assessment_dir/$(echo "$host" | tr '.' '_')"
    mkdir -p "$host_dir"
    
    echo -e "  ${BLUE}[FULL_SCAN] Comprehensive scan...${NC}"
    nmap -A -T4 "$host" -oA "$host_dir/full_scan" > /dev/null
    
    # Security checks
    check_ftp_security "$host" "$host_dir"
    check_ssh_security "$host" "$host_dir"
    
    generate_security_score "$host" "$host_dir"
}

# Check FTP security
check_ftp_security() {
    local host="$1"
    local host_dir="$2"
    
    if nmap -p21 "$host" | grep -q "open"; then
        echo -e "  ${RED}🚨 FTP service enabled${NC}"
        echo "CRITICAL: FTP service enabled" > "$host_dir/ftp_alert.txt"
    else
        echo -e "  ${GREEN}✅ FTP service disabled${NC}"
    fi
}

# Check SSH security
check_ssh_security() {
    local host="$1"
    local host_dir="$2"
    
    if nmap -p22 "$host" | grep -q "open"; then
        echo -e "  ${BLUE}[SSH] Checking SSH configuration${NC}"
        nmap -p22 --script ssh2-enum-algos "$host" -oA "$host_dir/ssh_algorithms" > /dev/null
        
        if grep -q "ssh-dss" "$host_dir/ssh_algorithms.nmap"; then
            echo -e "  ${YELLOW}⚠️  Weak SSH algorithms detected${NC}"
            echo "WARNING: Weak SSH algorithms" > "$host_dir/ssh_weak.txt"
        else
            echo -e "  ${GREEN}✅ SSH configuration appears secure${NC}"
        fi
    fi
}

# Generate security score for a device
generate_security_score() {
    local host="$1"
    local host_dir="$2"
    
    local score=100
    local issues=()
    
    # Deduct points for each issue
    if [ -f "$host_dir/ftp_alert.txt" ]; then
        score=$((score - 40))
        issues+=("FTP service enabled")
    fi
    
    if [ -f "$host_dir/ssh_weak.txt" ]; then
        score=$((score - 20))
        issues+=("Weak SSH algorithms")
    fi
    
    # Display score
    if [ "$score" -ge 80 ]; then
        echo -e "  ${GREEN}✅ Security Score: $score/100${NC}"
    elif [ "$score" -ge 60 ]; then
        echo -e "  ${YELLOW}⚠️  Security Score: $score/100${NC}"
    else
        echo -e "  ${RED}🚨 Security Score: $score/100${NC}"
    fi
    
    # Show issues
    if [ ${#issues[@]} -gt 0 ]; then
        echo -e "  Issues: ${issues[*]}"
    fi
}

# Assess single device
assess_single_device() {
    local target="$1"
    local assessment_dir="$2"
    
    echo -e "${BLUE}[ASSESSMENT] Assessing single device: $target${NC}"
    assess_network_device "$target" "$assessment_dir"
}
