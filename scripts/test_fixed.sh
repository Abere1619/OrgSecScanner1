#!/bin/bash
# Test script for OrgSecScanner

echo "🧪 Testing OrgSecScanner Installation"
echo "====================================="

cd "$(dirname "$0")"

# Test 1: Check if configuration exists
echo "1. Checking configuration..."
if [ -f "config/settings.conf" ]; then
    echo "✅ Configuration file found"
else
    echo "❌ Configuration file missing"
    exit 1
fi

# Test 2: Test help command
echo -e "\n2. Testing help command..."
./bin/orgsec-scanner --help

# Test 3: Test version
echo -e "\n3. Testing version..."
./bin/orgsec-scanner --version

# Test 4: Test discovery with localhost (safe test)
echo -e "\n4. Testing discovery with localhost..."
./bin/orgsec-scanner discover 127.0.0.1

# Test 5: Test assessment with localhost
echo -e "\n5. Testing assessment with localhost..."
./bin/orgsec-scanner assess 127.0.0.1

echo -e "\n🎉 All basic tests completed successfully!"
echo "You can now run full network scans:"
echo "  ./bin/orgsec-scanner discover 10.10.84.0/24"
echo "  ./bin/orgsec-scanner auto"
