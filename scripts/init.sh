#!/bin/sh
#*******************************************************************************
#  Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

INITSTATUSFILE=/tmp/init.status
SPMSTARTUPLOCK=$CC_HOME/bin/.startup.lock

if [ -f "$INITSTATUSFILE" ]
then
	initstate=`cat $INITSTATUSFILE`
	if [ "$initstate" = "OK Initialized" ]
	then
		echo "init.sh: reinitializing container"
		echo "Initializing" > $INITSTATUSFILE
	else 
		echo "init.sh: waiting for previous running initialization process"
		while `grep -qv OK $INITSTATUSFILE`
		do 
			echo -n .
			sleep 5
		done
		echo
	fi
else
	echo "Initializing" > $INITSTATUSFILE
fi
## do not start SPM in init.sh as it will be started by provision.sh or cce-entrypoint.sh
if [ -d $CC_HOME/profiles/SPM/bin -a ! -f "$SPMSTARTUPLOCK" ]; then
	touch "$SPMSTARTUPLOCK"
    $CC_HOME/profiles/SPM/bin/startup.sh
fi
sagcc list inventory products --wait-for-cc
echo Waiting for OSGI-CCE-ENGINE
sagcc list inventory components refresh=true -e OSGI-CCE-ENGINE -w 60
sagcc get monitoring state nodeAlias=local runtimeComponentId=OSGI-CCE-ENGINE -e ONLINE -w 300 



echo "############################"
echo "# Container initialization #"
echo "############################"
echo "$$" > /tmp/init.status
REPO_CREDS_BASIC=""

if [ ! -z $REPO_PRODUCT_URL ] && [ ! -z $REPO_FIX_URL ]; then

    sagcc exec templates composite import -i $CC_HOME/sag-cc-creds.yaml overwrite=true
    sagcc exec templates composite import -i $CC_HOME/sag-cc-builder-repos.yaml overwrite=true

    if [[ "$REPO_FIX_URL" == *"softwareag.com"* ]]; then # Empower/SDC?
        REPO_CREDS="EMPOWER"
        if [ -z $REPO_USERNAME ] || [ -z $REPO_PASSWORD ] ; then
            echo "ERROR: REPO_USERNAME and REPO_PASSWORD env vars must be provided to register $REPO_PRODUCT_URL or $REPO_FIX_URL repositories"
            exit 1
        fi
    else   
        REPO_CREDS="MIRROR"
    fi

    # custom credentials (Empower or private mirror SPM Administrator)
    if [ ! -z $REPO_USERNAME ] && [ ! -z $REPO_PASSWORD ] ; then
        
        echo "Registering credentials '$REPO_CREDS' for '$REPO_USERNAME/******' ..."

        sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
            credentials.username=$REPO_USERNAME \
            credentials.password=$REPO_PASSWORD \
            credentials.key=$REPO_CREDS
        
        REPO_CREDS_BASIC=" -u \"${REPO_USERNAME}:${REPO_PASSWORD}\""
        REPO_PRODUCT_CREDS="$REPO_CREDS"
        REPO_FIX_CREDS="$REPO_CREDS"
    
    else
        REPO_PRODUCT_CREDS="REPO-PRODUCT"
        REPO_FIX_CREDS="REPO-FIX"
        REPO_CREDS_BASIC=""

        echo "SKIP: REPO_USERNAME and REPO_PASSWORD env vars are not set. Registering default credentials $REPO_PRODUCT_CREDS and $REPO_FIX_CREDS ..."
        
        sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
            credentials.username=sum \
            credentials.password=sum \
            credentials.key=$REPO_FIX_CREDS
        
        sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
            credentials.username=latest \
            credentials.password=latest \
            credentials.key=$REPO_PRODUCT_CREDS
    fi

    echo "Registering repositories ..."
    echo "$REPO_PRODUCT_NAME: $REPO_PRODUCT_URL with $REPO_PRODUCT_CREDS"
    echo "$REPO_FIX_NAME: $REPO_FIX_URL with $REPO_FIX_CREDS"

    sagcc exec templates composite apply sag-cc-builder-repos --sync-job -c 5 -e DONE \
        repo.product.name=$REPO_PRODUCT_NAME \
        repo.product.credentials.key=$REPO_PRODUCT_CREDS \
        repo.product.url=$REPO_PRODUCT_URL \
        repo.fix.name=$REPO_FIX_NAME \
        repo.fix.url=$REPO_FIX_URL \
        repo.fix.credentials.key=$REPO_FIX_CREDS
else
    echo "SKIP: REPO_PRODUCT_URL or REPO_FIX_URL not set. No new repositories are registered"    
fi

LICENSES_FILE="$CC_HOME/licenses/licenses.zip"
if [ -r $LICENSES_FILE ]; then
    echo "Importing license keys from: '$LICENSES_FILE' ..."
    sagcc add license-tools keys -i $LICENSES_FILE
else
    echo "SKIP: LICENSE_FILE not found. No new license keys are imported"    
fi

PRODUCT_LICENSES_FILE=$CC_HOME/licenses/product_licenses.zip
if [ -f $PRODUCT_LICENSES_FILE ]; then
    echo "Importing products license keys from: '$PRODUCT_LICENSES_FILE' ..."
    sagcc add license-tools keys -i $PRODUCT_LICENSES_FILE
#    rm $PRODUCT_LICENSES_FILE
else
    echo "SKIP: $LICENSE_FILE is file found. No new license keys are imported"
fi


if [ ! -z $LICENSES_URL ]; then
    echo "Importing license keys from: '$LICENSES_URL' ..."
    curl -k -o ~/licenses.zip "$LICENSES_URL" && \
    sagcc add license-tools keys -i ~/licenses.zip && \
    rm ~/licenses.zip
else
    echo "SKIP: LICENSES_URL env variable not set. No new license keys are imported"    
fi
echo List of imported licenses:
sagcc list license-tools keys
rm -f "$SPMSTARTUPLOCK"
echo "OK Initialized" > $INITSTATUSFILE

