#!/bin/sh

sagcc list inventory products --wait-for-cc

if [ -d $SAG_HOME/profiles/SPM/bin ]; then
    $SAG_HOME/profiles/SPM/bin/startup.sh
fi

echo -e "\n####################"
echo "# Initialization   #"
echo -e "\n####################"

if [ ! -z $LICENSES_URL ]; then
    # https://solutionbook.softwareag.com/sb-web/page/detail_page.xhtml?guid=1227042885&type=platforms
    echo "Importing license keys from: $LICENSES_URL ..."
    curl -o licenses.zip $LICENSES_URL && \
    sagcc add license-tools keys -i licenses.zip && \
    rm licenses.zip
else
    echo "SKIP: License URL is not provided. No license keys are imported"    
fi

if [ ! -z $REPO_HOST ]; then
    echo "Registering repositories ..."
    sagcc exec templates composite apply sag-cc-creds-dev --sync-job -c 5
    sagcc exec templates composite apply sag-cc-builder-dev --sync-job -c 5 \
        repo.product=$REPO_PRODUCT repo.fix=$REPO_FIX repo.host=$REPO_HOST --sync-job
else
    echo "SKIP: Repo host is not provided. No repositories are registered"
fi

$CC_HOME/inventory.sh
