#!/bin/bash
# Test OrgSecScanner functionality

echo "🧪 Testing OrgSecScanner"
echo "========================"

cd "$(dirname "$0")"

# Test 1: Help command
echo "1. Testing help command..."
./bin/orgsec-scanner --help

# Test 2: Version
echo -e "\n2. Testing version..."
./bin/orgsec-scanner --version

# Test 3: Discovery (limited scope)
echo -e "\n3. Testing discovery (single host)..."
./bin/orgsec-scanner discover 127.0.0.1

# Test 4: Assessment (single host)
echo -e "\n4. Testing assessment..."
./bin/orgsec-scanner assess 127.0.0.1

echo -e "\n✅ Basic functionality tests completed"
echo "Check the reports/ directory for generated reports"
