#!/bin/bash
echo "🔍 Verifying Authorship Information"
echo "==================================="

echo "Checking files for 'Abere Worku':"
files_with_name=$(grep -r "Abere Worku" . --exclude-dir=.git 2>/dev/null | wc -l)
echo "✅ Found in $files_with_name files"

echo -e "\nKey files checked:"
important_files=("LICENSE" "README.md" "AUTHORS" "bin/orgsec-scanner")
for file in "${important_files[@]}"; do
    if grep -q "Abere Worku" "$file" 2>/dev/null; then
        echo "✅ $file"
    else
        echo "❌ $file"
    fi
done

echo -e "\nCurrent version tags:"
git tag -l

echo -e "\n🎉 Authorship verification complete!"
