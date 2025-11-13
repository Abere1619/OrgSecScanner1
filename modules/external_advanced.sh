#!/bin/bash
# Advanced External Scanning Module

# Get base directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Safe public targets for practice
SAFE_TARGETS=("8.8.8.8" "1.1.1.1" "9.9.9.9" "208.67.222.222" "8.8.4.4")

# Legal disclaimer
show_legal_warning() {
    echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                     LEGAL WARNING                           ║${NC}"
    echo -e "${RED}║  UNAUTHORIZED SCANNING IS ILLEGAL AND UNETHICAL             ║${NC}"
    echo -e "${RED}║                                                              ║${NC}"
    echo -e "${RED}║  ✅ SAFE: Public services, your own networks, with permission║${NC}"
    echo -e "${RED}║  ❌ ILLEGAL: Others networks without explicit permission    ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -p "Do you have legal permission to scan the target? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo -e "${RED}Scanning cancelled. Stay legal and ethical!${NC}"
        exit 1
    fi
}

# Comprehensive external scan
comprehensive_external_scan() {
    local target="$1"
    local timestamp
    timestamp=$(date '+%Y%m%d_%H%M%S')
    local scan_dir="$BASE_DIR/data/external_advanced_$timestamp"
    
    mkdir -p "$scan_dir"
    
    show_legal_warning
    
    echo -e "${BLUE}[EXTERNAL-ADVANCED] Comprehensive scan of: $target${NC}"
    
    # Phase 1: Host Discovery
    echo -e "\n${GREEN}[PHASE 1] Host Discovery${NC}"
    nmap -T2 -sn "$target" -oA "$scan_dir/1_host_discovery" > /dev/null
    
    # Phase 2: Service Detection
    echo -e "\n${GREEN}[PHASE 2] Service Detection${NC}"
    nmap -T2 -sV -sC "$target" -oA "$scan_dir/2_service_detection" > /dev/null
    
    # Phase 3: Security Scripts
    echo -e "\n${GREEN}[PHASE 3] Security Assessment${NC}"
    nmap -T2 --script "safe and not intrusive" "$target" -oA "$scan_dir/3_security_scripts" > /dev/null
    
    generate_advanced_report "$scan_dir" "$target"
}

# Quick external assessment
quick_external_assess() {
    local target="$1"
    
    echo -e "${BLUE}[QUICK-EXTERNAL] Quick assessment of: $target${NC}"
    echo -e "${YELLOW}Note: This is a quick scan for basic information${NC}"
    
    # Quick but comprehensive scan
    nmap -T3 -sV -sC --script "default,safe" "$target"
}

# Safe practice mode
safe_practice_mode() {
    echo -e "${GREEN}[SAFE-PRACTICE] Scanning safe public targets${NC}"
    echo "This mode uses well-known public services for practice"
    
    for target in "${SAFE_TARGETS[@]}"; do
        echo -e "\n${YELLOW}Scanning: $target${NC}"
        nmap -T2 -F "$target" | grep -E "Nmap scan|open" | head -5
        echo "---"
    done
}

# Generate advanced report
generate_advanced_report() {
    local scan_dir="$1"
    local target="$2"
    local report_file="$BASE_DIR/reports/external_advanced_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "ADVANCED EXTERNAL SECURITY ASSESSMENT"
        echo "====================================="
        echo "Target: $target"
        echo "Date: $(date)"
        echo "Tool: OrgSecScanner by Abere Worku"
        echo ""
        
        echo "SCAN SUMMARY"
        echo "============"
        if [ -f "$scan_dir/1_host_discovery.nmap" ]; then
            echo "Host Discovery:"
            grep "Nmap scan report" "$scan_dir/1_host_discovery.nmap" | head -10
            echo ""
        fi
        
        echo "SERVICES DISCOVERED"
        echo "=================="
        if [ -f "$scan_dir/2_service_detection.nmap" ]; then
            grep "open" "$scan_dir/2_service_detection.nmap" | head -20
            echo ""
        fi
        
        echo "SECURITY FINDINGS"
        echo "================="
        if [ -f "$scan_dir/3_security_scripts.nmap" ]; then
            grep -E "VULNERABLE|CVE|WARNING" "$scan_dir/3_security_scripts.nmap" | head -10
        fi
        
        echo ""
        echo "RECOMMENDATIONS"
        echo "==============="
        echo "1. Review all open services"
        echo "2. Ensure proper authorization for scanning"
        echo "3. Implement security best practices"
        echo "4. Regular security assessments"
        
    } > "$report_file"
    
    echo -e "${GREEN}[REPORT] Advanced external report generated: $report_file${NC}"
}

# Main function
main() {
    case "${1:-}" in
        "comprehensive")
            comprehensive_external_scan "${2:-}"
            ;;
        "quick")
            quick_external_assess "${2:-}"
            ;;
        "practice")
            safe_practice_mode
            ;;
        "safe-targets")
            echo -e "${GREEN}Safe practice targets:${NC}"
            printf '  %s\n' "${SAFE_TARGETS[@]}"
            ;;
        *)
            echo "Usage: $0 [comprehensive TARGET|quick TARGET|practice|safe-targets]"
            echo ""
            echo "Examples:"
            echo "  $0 comprehensive 8.8.8.8     # Full external assessment"
            echo "  $0 quick 1.1.1.1            # Quick security check"
            echo "  $0 practice                 # Safe practice on public DNS"
            echo "  $0 safe-targets             # List safe practice targets"
            ;;
    esac
}

# Only run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
