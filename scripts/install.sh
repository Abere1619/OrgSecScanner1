#!/bin/bash
# OrgSecScanner Installation Script

echo "🛡️ Installing OrgSecScanner - Organization Security Scanner"
echo "=========================================================="

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Please do not run as root. Run as regular user."
    exit 1
fi

# Check dependencies
echo "Checking dependencies..."
for cmd in nmap awk grep sed; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ Missing dependency: $cmd"
        echo "Please install: sudo apt install $cmd"
        exit 1
    fi
done

echo "✅ All dependencies met"

# Create directory structure
echo "Creating directory structure..."
mkdir -p {bin,config,modules,reports,logs,data}

# Set permissions
echo "Setting permissions..."
chmod +x bin/orgsec-scanner
chmod +x modules/*.sh
chmod +x install.sh

# Create initial baseline
echo "Creating initial configuration..."
cat > config/settings.conf << 'EOL'
# OrgSecScanner Configuration
DEFAULT_NETWORK="10.10.84.0/24"
SCAN_TIMING="-T4"
CRITICAL_HOSTS=("10.10.84.251" "10.10.84.252" "10.10.84.253" "10.10.84.254" "10.10.84.33")
HIGH_RISK_PORTS=("21" "23" "135" "139" "445" "3389")
EOL

echo "✅ OrgSecScanner installed successfully!"
echo ""
echo "Quick Start:"
echo "  ./bin/orgsec-scanner discover    # Discover network devices"
echo "  ./bin/orgsec-scanner assess      # Security assessment"
echo "  ./bin/orgsec-scanner auto        # Complete automated scan"
echo ""
echo "For help: ./bin/orgsec-scanner --help"
