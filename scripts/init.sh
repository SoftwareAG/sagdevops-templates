#!/bin/sh
#*******************************************************************************
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
#*******************************************************************************
set -e

sagcc list inventory products --wait-for-cc

if [ -d $SAG_HOME/profiles/SPM/bin ]; then
    $SAG_HOME/profiles/SPM/bin/startup.sh
fi

echo -e "\n"
echo "####################"
echo "# Initialization   #"
echo "####################"
echo -e "\n"

LICENSES_FILE="$CC_HOME/licenses/licenses.zip"
if [ -f $LICENSES_FILE ]; then
    echo "Importing license keys from: '$LICENSES_FILE' ..."
    sagcc add license-tools keys -i $LICENSES_FILE
    # rm $LICENSES_FILE
else
    echo "SKIP: $LICENSE_FILE is file found. No new license keys are imported"    
fi
if [ ! -z $LICENSES_URL ]; then
    # https://solutionbook.softwareag.com/sb-web/page/detail_page.xhtml?guid=1227042885&type=platforms
    # https://iwiki.eur.ad.sag/pages/downloadallattachments.action?pageId=517544534
    echo "Importing license keys from: '$LICENSES_URL' ..."
    curl -k -o ~/licenses.zip "$LICENSES_URL" && \
    sagcc add license-tools keys -i ~/licenses.zip && \
    rm ~/licenses.zip
else
    echo "SKIP: LICENSES_URL env var is not set. No new license keys are imported"    
fi

# default credentials
REPO_CREDS=${REPO_CREDS:-REPO}

if [ ! -z $REPO_USERNAME ] && [ ! -z $REPO_PASSWORD ] ; then
    echo "Registering credentials '$REPO_CREDS' for '$REPO_USERNAME/******' ..."

    sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
        credentials.username=$REPO_USERNAME \
        credentials.password=$REPO_PASSWORD \
        credentials.key=$REPO_CREDS
else
    echo "SKIP: REPO_USERNAME and REPO_PASSWORD env vars are not set. No new credentials are registered"
fi

if [ ! -z $REPO_PRODUCT_URL ]; then
    if [ ! -z $REPO_FIX_URL ]; then
        echo "Registering private MIRROR repositories $REPO_CREDS ..."
        echo "products: $REPO_PRODUCT_URL"
        echo "fixes:    $REPO_FIX_URL"

        sagcc exec templates composite apply sag-cc-builder-repos --sync-job -c 5 -e DONE \
            repo.product.credentials.key=$REPO_CREDS \
            repo.product.url=$REPO_PRODUCT_URL \
            repo.fix.url=$REPO_FIX_URL
    else
        echo "Registering public MASTER repositories with $REPO_CREDS ..."
        echo "products: $REPO_PRODUCT_URL"
        
        sagcc exec templates composite apply sag-cc-builder-repos --sync-job -c 5 -e DONE \
            repo.product.credentials.key=$REPO_CREDS \
            repo.product.url=$REPO_PRODUCT_URL
    fi
else
    if [ ! -z $REPO_HOST ]; then
        echo "Registering internal MIRROR '$REPO_PRODUCT' and '$REPO_FIX' repositories on '$REPO_HOST' ..."
        sagcc exec templates composite apply sag-cc-creds-dev --sync-job -c 2 -e DONE
        sagcc exec templates composite apply sag-cc-builder-dev --sync-job -c 5 --sync-job -e DONE \
            repo.product=$REPO_PRODUCT repo.fix=$REPO_FIX repo.host=$REPO_HOST 
    else
        echo "SKIP: REPO_HOST env var is not set. No repositories are registered"
    fi
fi
