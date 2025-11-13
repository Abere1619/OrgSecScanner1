#!/bin/bash
# External Scanner Wrapper Script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/.."

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
    echo "OrgSecScanner - External Scanning"
    echo "================================="
    echo "Usage: $0 [command] [target]"
    echo ""
    echo "Commands:"
    echo "  scan TARGET      - Comprehensive external scan"
    echo "  quick TARGET     - Quick external assessment"
    echo "  practice         - Safe practice on public DNS"
    echo "  targets          - List safe practice targets"
    echo ""
    echo "Examples:"
    echo "  $0 scan 8.8.8.8"
    echo "  $0 quick 1.1.1.1"
    echo "  $0 practice"
}

case "${1:-}" in
    "scan")
        if [ -z "$2" ]; then
            echo -e "${RED}Please specify a target${NC}"
            show_help
            exit 1
        fi
        echo -e "${BLUE}[EXTERNAL] Comprehensive scan of: $2${NC}"
        "$BASE_DIR/modules/external_advanced.sh" comprehensive "$2"
        ;;
    "quick")
        if [ -z "$2" ]; then
            echo -e "${RED}Please specify a target${NC}"
            show_help
            exit 1
        fi
        echo -e "${BLUE}[EXTERNAL] Quick assessment of: $2${NC}"
        "$BASE_DIR/modules/external_advanced.sh" quick "$2"
        ;;
    "practice")
        echo -e "${BLUE}[EXTERNAL] Safe practice mode${NC}"
        "$BASE_DIR/modules/external_advanced.sh" practice
        ;;
    "targets")
        "$BASE_DIR/modules/external_advanced.sh" safe-targets
        ;;
    *)
        show_help
        ;;
esac
