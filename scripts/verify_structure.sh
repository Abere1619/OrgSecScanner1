#!/bin/bash
echo "🔍 Verifying Project Structure"
echo "=============================="

required_dirs=("bin" "config" "modules" "scripts" "logs" "data" "reports")
required_files=("bin/orgsec-scanner" "config/settings.conf.example" "README.md" "LICENSE" ".gitignore")

echo "Checking directories:"
for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir/"
    else
        echo "❌ $dir/ (missing)"
    fi
done

echo -e "\nChecking files:"
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (missing)"
    fi
done

echo -e "\n🎉 Structure verification complete!"
