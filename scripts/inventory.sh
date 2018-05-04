#!/bin/sh

echo -e "\n"
echo "####################"
echo "# Inventory Report #"
echo "####################"
echo -e "\n"

echo "\n### Installed Command Central products:"
sagcc list inventory products nodeAlias=local properties=product.displayName,product.version.string
echo "\n### Installed Command Central fixes:"
sagcc list inventory fixes nodeAlias=local properties=fix.displayName,fix.version

echo -e "\n### Registered PRODUCT repos:"
sagcc list repository products properties="*"

echo -e "\n### Registered FIX repos:"
sagcc list repository fixes properties="*"

echo -e "\n### Registered ASSET repos:"
sagcc list repository assets properties="*"

echo -e "\n### Registered lisense KEYS:"
sagcc list license-tools keys properties="*"

echo -e "\n### Registered NODES:"
sagcc list landscape nodes properties="*"

echo -e "\n### Registered TEMPLATES:"
sagcc list templates composite

echo -e "\n\n### END of report"
echo "####################"
echo -e "\n\n"
