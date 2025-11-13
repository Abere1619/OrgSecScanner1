#!/bin/bash
# Remediation Module - Security Issue Remediation Guidance

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

# Show remediation guidance
show_remediation_guidance() {
    echo -e "${BLUE}[REMEDIATION] Security Issue Remediation Guide${NC}"
    echo "================================================"
    
    # Check for latest assessment
    local latest_assessment
    latest_assessment=$(ls -td "$BASE_DIR/data/assessment_"* 2>/dev/null | head -1)
    
    if [ -z "$latest_assessment" ]; then
        echo -e "${YELLOW}[INFO] No assessment data found. Run assessment first.${NC}"
        echo "Run: ./bin/orgsec-scanner assess"
        return 1
    fi
    
    # Generate remediation based on findings
    generate_remediation_from_findings "$latest_assessment"
}

# Generate remediation from findings
generate_remediation_from_findings() {
    local assessment_dir="$1"
    
    echo -e "\n${YELLOW}=== CRITICAL ISSUES ===${NC}"
    show_ftp_remediation "$assessment_dir"
    
    echo -e "\n${YELLOW}=== HIGH PRIORITY ISSUES ===${NC}"
    show_ssh_remediation "$assessment_dir"
    
    echo -e "\n${YELLOW}=== SECURITY HARDENING ===${NC}"
    show_general_hardening
    
    # Generate remediation report
    generate_remediation_report "$assessment_dir"
}

# Show FTP remediation
show_ftp_remediation() {
    local assessment_dir="$1"
    
    local ftp_issues
    ftp_issues=$(find "$assessment_dir" -name "ftp_alert.txt" 2>/dev/null | wc -l)
    
    if [ "$ftp_issues" -gt 0 ]; then
        echo -e "${RED}🚨 FTP SERVICE DETECTED${NC}"
        echo "Issues Found: $ftp_issues"
        echo ""
        echo "IMMEDIATE ACTIONS REQUIRED:"
        echo "1. Disable FTP service on affected devices:"
        find "$assessment_dir" -name "ftp_alert.txt" 2>/dev/null | while read -r alert; do
            local device
            device=$(dirname "$alert" | xargs basename | tr '_' '.')
            echo "   - $device"
        done
        echo ""
        echo "REMEDIATION STEPS for Huawei Switches:"
        echo "1. Connect via SSH: ssh admin@10.10.84.253"
        echo "2. Enter system view: system-view"
        echo "3. Disable FTP: ftp server disable"
        echo "4. Save configuration: commit && save"
        echo ""
        echo "ALTERNATIVES:"
        echo "- Use SCP/SFTP for secure file transfer"
        echo "- Implement FTPS if FTP is absolutely required"
        echo ""
    else
        echo -e "${GREEN}✅ No FTP services detected${NC}"
    fi
}

# Show SSH remediation
show_ssh_remediation() {
    local assessment_dir="$1"
    
    local ssh_issues
    ssh_issues=$(find "$assessment_dir" -name "ssh_weak.txt" 2>/dev/null | wc -l)
    
    if [ "$ssh_issues" -gt 0 ]; then
        echo -e "${YELLOW}⚠️  WEAK SSH CONFIGURATIONS${NC}"
        echo "Issues Found: $ssh_issues"
        echo ""
        echo "REMEDIATION STEPS for Huawei Switches:"
        echo "1. Connect via SSH and run these commands:"
        echo "   system-view"
        echo "   ssh server key-exchange dh_group14_sha1"
        echo "   ssh server key-exchange dh_group1_sha1" 
        echo "   ssh server cipher 3des_cbc"
        echo "   ssh server hmac sha1_96"
        echo "2. Enable strong algorithms:"
        echo "   ssh server key-exchange dh_group16_sha512"
        echo "   ssh server key-exchange dh_group15_sha512"
        echo "   ssh server cipher aes256_ctr"
        echo "   ssh server cipher aes128_ctr"
        echo "   ssh server hmac hmac_sha2_256"
        echo "3. Save configuration: commit && save"
        echo ""
    else
        echo -e "${GREEN}✅ No weak SSH configurations detected${NC}"
    fi
}

# Show general hardening
show_general_hardening() {
    echo -e "${GREEN}🛡️  GENERAL SECURITY HARDENING${NC}"
    echo ""
    echo "NETWORK HARDENING:"
    echo "1. Implement network segmentation"
    echo "2. Configure firewall rules"
    echo "3. Enable logging and monitoring"
    echo "4. Regular vulnerability assessments"
    echo ""
    echo "SYSTEM HARDENING:"
    echo "1. Apply security patches regularly"
    echo "2. Use strong authentication methods"
    echo "3. Implement least privilege access"
    echo "4. Regular security awareness training"
    echo ""
}

# Generate remediation report
generate_remediation_report() {
    local assessment_dir="$1"
    local report_file="$BASE_DIR/reports/remediation_guide_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "SECURITY REMEDIATION GUIDE"
        echo "========================="
        echo "Generated: $(date)"
        echo ""
        
        echo "CRITICAL ACTIONS (24-48 HOURS)"
        echo "-----------------------------"
        echo "1. Disable FTP services"
        echo "2. Review and fix SSH configurations"
        echo "3. Secure web interfaces"
        echo ""
        
        echo "DETAILED REMEDIATION STEPS"
        echo "-------------------------"
        find "$assessment_dir" -name "ftp_alert.txt" 2>/dev/null | while read -r alert; do
            local device
            device=$(dirname "$alert" | xargs basename | tr '_' '.')
            echo "Device: $device"
            echo "Steps:"
            echo "  1. SSH to device: ssh admin@$device"
            echo "  2. Enter system view: system-view"
            echo "  3. Disable FTP: ftp server disable"
            echo "  4. Save: commit && save"
            echo ""
        done
        
    } > "$report_file"
    
    echo -e "${GREEN}[REPORT] Remediation guide generated: $report_file${NC}"
}
