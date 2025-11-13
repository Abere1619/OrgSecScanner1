#!/bin/bash
# Script to update main orgsec-scanner with external scanning

FILE="bin/orgsec-scanner"

# Find the main case statement and add external commands
sed -i '/case "${1:-}" in/a\
        "external-scan")\
            run_external_scan "${2:-}"\
            ;;\
        "external-quick")\
            run_external_quick "${2:-}"\
            ;;\
        "external-practice")\
            run_external_practice\
            ;;' "$FILE"

# Add the external scanning functions before the main function call
sed -i '/# Run main function/i\
# External scanning functions\
run_external_scan() {\
    local target="${1:-}"\
    if [ -z "$target" ]; then\
        echo -e "${RED}Please specify a target${NC}"\
        echo "Usage: $0 external-scan TARGET"\
        echo "Example: $0 external-scan 8.8.8.8"\
        return 1\
    fi\
    echo -e "${BLUE}[EXTERNAL] Running comprehensive external scan${NC}"\
    source "$BASE_DIR/modules/external_advanced.sh"\
    comprehensive_external_scan "$target"\
}\
\
run_external_quick() {\
    local target="${1:-}"\
    if [ -z "$target" ]; then\
        echo -e "${RED}Please specify a target${NC}"\
        echo "Usage: $0 external-quick TARGET"\
        return 1\
    fi\
    echo -e "${BLUE}[EXTERNAL] Running quick external assessment${NC}"\
    source "$BASE_DIR/modules/external_advanced.sh"\
    quick_external_assess "$target"\
}\
\
run_external_practice() {\
    echo -e "${BLUE}[EXTERNAL] Safe practice mode${NC}"\
    source "$BASE_DIR/modules/external_advanced.sh"\
    safe_practice_mode\
}' "$FILE"

echo "Main script updated successfully!"
