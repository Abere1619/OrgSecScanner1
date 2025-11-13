📖 Usage
Basic Commands
bash

# Complete automated scan
./bin/orgsec-scanner auto

# Individual modules
./bin/orgsec-scanner discover    # Network discovery
./bin/orgsec-scanner assess      # Security assessment
./bin/orgsec-scanner report      # Generate reports
./bin/orgsec-scanner remediate   # Get remediation guidance

Targeted Scanning
bash

# Scan specific network
./bin/orgsec-scanner discover 192.168.1.0/24

# Assess specific device
./bin/orgsec-scanner assess 10.10.84.253

📊 Sample Output
text

🛡️ OrgSecScanner - Network Security Assessment

📡 Discovery: Found 42 devices
🔒 Assessment: 1 critical, 3 warning issues
📈 Security Posture: Needs Improvement

🚨 Critical Issues:
- FTP service enabled on network switch (10.10.84.253)

✅ Recommendations:
- Disable FTP service immediately
- Harden SSH configurations
- Implement network segmentation

