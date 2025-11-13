# OrgSecScanner - Organization Security Scanner

![OrgSecScanner Banner](https://img.shields.io/badge/OrgSecScanner-Security%20Assessment-blue)
![Version](https://img.shields.io/badge/Version-1.1.0-green)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Unix-lightgrey)

A comprehensive network security assessment tool for organizations to discover, assess, and monitor their network infrastructure. Built with ❤️ by **Abere Worku**.

## 📖 Table of Contents

- [Overview](#overview)
- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Usage Guide](#-usage-guide)
- [Modules](#-modules)
- [Configuration](#-configuration)
- [Security & Legal](#-security--legal)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

## Overview

OrgSecScanner is an automated network security assessment tool designed for organizations to maintain visibility and security of their network infrastructure.

### 🎯 What It Does

- **Network Discovery**: Automatically finds all devices on your network
- **Security Assessment**: Identifies vulnerabilities and misconfigurations
- **Automated Reporting**: Generates professional security reports
- **Remediation Guidance**: Provides step-by-step fixes for issues
- **Continuous Monitoring**: Ongoing network security monitoring

### 🏢 Who It's For

- **IT Administrators**: Network monitoring and maintenance
- **Security Teams**: Vulnerability assessment and compliance
- **System Administrators**: Infrastructure security checks
- **Penetration Testers**: Authorized security testing

## 🚀 Features

### Core Capabilities

| Feature | Description | Use Case |
|---------|-------------|----------|
| **Network Discovery** | Find all active devices | Inventory management |
| **Service Detection** | Identify running services | Service documentation |
| **Security Assessment** | Check vulnerabilities | Risk assessment |
| **Automated Reporting** | Generate reports | Compliance documentation |
| **Remediation Guidance** | Get fixes for issues | Problem resolution |
| **External Scanning** | Scan external networks | With proper permission |

### Advanced Features

- **Multi-Network Support**: Internal and external networks
- **Risk Scoring**: Automated security scores (0-100)
- **Legal Compliance**: Built-in permission checks
- **Safe Practice Mode**: Public DNS servers for training

## 🎯 Quick Start

### Installation

```bash
# Clone and install
git clone https://github.com/Abere1619/OrgSecScanner1.git
cd OrgSecScanner1
chmod +x scripts/install.sh
./scripts/install.sh

Basic Usage
bash

# Complete automated scan
./bin/orgsec-scanner auto

# Individual modules
./bin/orgsec-scanner discover    # Network discovery
./bin/orgsec-scanner assess      # Security assessment
./bin/orgsec-scanner report      # Generate reports
./bin/orgsec-scanner remediate   # Get fixes

# External scanning (with permission)
./bin/orgsec-scanner external-scan 8.8.8.8
./bin/orgsec-scanner external-practice

First Scan

    Configure your network:
    bash

nano config/settings.conf
# Set DEFAULT_NETWORK to your network

Run discovery:
bash

./bin/orgsec-scanner discover

View results:
bash

ls reports/
cat reports/latest_discovery_report.txt

🛠️ Installation
Prerequisites

    Linux/Unix system (Ubuntu, Debian, CentOS, macOS)

    Nmap network scanner

    Bash shell environment

Automated Installation
bash

git clone https://github.com/Abere1619/OrgSecScanner1.git
cd OrgSecScanner1
chmod +x scripts/install.sh
./scripts/install.sh

Manual Installation
bash

# Install dependencies
sudo apt update && sudo apt install nmap

# Clone repository
git clone https://github.com/Abere1619/OrgSecScanner1.git
cd OrgSecScanner1

# Set permissions
chmod +x bin/orgsec-scanner modules/*.sh scripts/*.sh

# Create configuration
cp config/settings.conf.example config/settings.conf
# Edit config/settings.conf with your network

📖 Usage Guide
Basic Commands
Command	Description	Example
discover [NETWORK]	Network discovery	./bin/orgsec-scanner discover 192.168.1.0/24
assess [TARGET]	Security assessment	./bin/orgsec-scanner assess 192.168.1.1
remediate	Remediation guidance	./bin/orgsec-scanner remediate
report	Generate reports	./bin/orgsec-scanner report
auto	Complete scan	./bin/orgsec-scanner auto
External Scanning
Command	Description	Legal Requirement
external-scan TARGET	Comprehensive external scan	Written permission
external-quick TARGET	Quick assessment	Written permission
external-practice	Safe practice	No permission needed
Examples

Internal Network:
bash

# Discover devices
./bin/orgsec-scanner discover 10.10.84.0/24

# Assess specific server
./bin/orgsec-scanner assess 10.10.84.253

# Get remediation
./bin/orgsec-scanner remediate

External Networks:
bash

# Safe practice (no permission needed)
./bin/orgsec-scanner external-practice

# Quick scan (with permission)
./bin/orgsec-scanner external-quick 8.8.8.8

# Comprehensive scan (with permission)
./bin/orgsec-scanner external-scan 203.0.113.0/24

🧩 Modules
Discovery Module

    Host discovery using ICMP and ARP

    Service detection on discovered hosts

    Device classification

    Network topology mapping

Assessment Module

    Service vulnerability scanning

    Security configuration checks

    Risk scoring (0-100 scale)

    Compliance checking

Remediation Module

    Step-by-step remediation guides

    Configuration templates

    Security hardening recommendations

Reporting Module

    HTML and text report formats

    Executive summaries

    Technical details

    Risk prioritization

External Module

    Legal compliance checking

    Safe practice mode

    Rate-limited scanning

⚙️ Configuration
Main Configuration

Edit config/settings.conf:
bash

# Network to scan
DEFAULT_NETWORK="10.10.84.0/24"

# Critical devices
CRITICAL_HOSTS=("10.10.84.251" "10.10.84.252" "10.10.84.253")

# Security thresholds
MAX_FTP_SERVERS=0
MAX_TELNET_SERVERS=0

# External scanning
EXTERNAL_SCAN_TIMING="-T2"
SAFE_PRACTICE_TARGETS=("8.8.8.8" "1.1.1.1")

Scan Timing

    -T0: Paranoid (slowest)

    -T1: Sneaky

    -T2: Polite

    -T3: Normal

    -T4: Aggressive

    -T5: Insane (fastest)

🛡️ Security & Legal
⚠️ Legal Warning

Unauthorized scanning is illegal and unethical
✅ Legal Scanning

    Your own networks

    Networks with written permission

    Public services (DNS, web servers)

    TEST-NET ranges (192.0.2.0/24)

❌ Illegal Scanning

    Others' networks without permission

    Government/military networks

    Causing service disruption

Safety Features

    Automatic permission checking

    Rate limiting

    Safe practice mode

    Non-intrusive scanning defaults

🔧 Troubleshooting
Common Issues

"Configuration file not found"
bash

cp config/settings.conf.example config/settings.conf

"Permission denied"
bash

chmod +x bin/orgsec-scanner modules/*.sh scripts/*.sh

"nmap not found"
bash

sudo apt update && sudo apt install nmap

Performance Tips

Large Networks:
bash

# Use faster timing
SCAN_TIMING="-T4"

# Split networks
./bin/orgsec-scanner discover 10.10.84.0/25
./bin/orgsec-scanner discover 10.10.84.128/25

Sensitive Networks:
bash

# Use slower scanning
SCAN_TIMING="-T2"

🤝 Contributing

We welcome contributions! Please see CONTRIBUTING.md for details.
How to Contribute

    Fork the repository

    Create a feature branch

    Make your changes

    Test thoroughly

    Submit a pull request

Development
bash

# Fork and clone
git clone https://github.com/yourusername/OrgSecScanner1.git
cd OrgSecScanner1

# Create development branch
git checkout -b feature/your-feature

# Test changes
./scripts/verify_structure.sh
./bin/orgsec-scanner auto

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

Copyright (c) 2025 Abere Worku
🙏 Acknowledgments

    Nmap Project: Network scanning engine

    Security Community: Inspiration and best practices

    Open Source Contributors: Community support

📞 Support

    Issues: GitHub Issues

    Documentation: This README

    Author: Abere Worku

OrgSecScanner - Making organizational security accessible and automated! 🔒

Built with passion for cybersecurity by Abere Worku
