#!/bin/sh

sagcc list inventory products --wait-for-cc

if [ -d $SAG_HOME/profiles/SPM/bin ]; then
    $SAG_HOME/profiles/SPM/bin/startup.sh
fi

if [ ! -z $LICENSES_URL ]; then
    echo "License URL is provided: $LICENSES_URL "
    curl -o licenses.zip $LICENSES_URL && \
    sagcc add license-tools keys -i licenses.zip && \
    rm licenses.zip
fi

if [ ! -z $REPO_HOST ]; then
    echo "Registering repositories ..."
    sagcc exec templates composite apply sag-cc-creds-dev --sync-job -c 5
    sagcc exec templates composite apply sag-cc-builder-dev --sync-job -c 5 \
        repo.product=$REPO_PRODUCT repo.fix=$REPO_FIX repo.host=$REPO_HOST --sync-job
fi

echo "##########################"
echo "#### Inventory Report ####"
echo "##########################"

echo -e "\n### Product repositories"
sagcc list repository products properties="*"

echo -e "\n### Fix repositories"
sagcc list repository fixes properties="*"

echo -e "\n### Asset repositories"
sagcc list repository assets properties="*"

echo -e "\n### Lisense keys"
sagcc list license-tools keys properties="*"

echo -e "\n### Nodes"
sagcc list landscape nodes properties="*"

echo -e "\n### Templates"
sagcc list templates composite

echo -e "\n\nCommand Central Builder is READY"
