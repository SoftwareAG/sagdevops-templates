#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export mws_instance_name=${__mws_instance_name:-default}

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MFTTransfer --wait-for-cc

    export CC_WAIT=180
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.MFTPortal

    echo "Verifying instances ..."
    sagcc get inventory components -e "OSGI-MWS_${__mws_instance_name}"

    echo "Start the instance ..."
    sagcc exec lifecycle components "OSGI-MWS_${__mws_instance_name}" restart -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus "OSGI-MWS_${__mws_instance_name}" -e ONLINE
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage -s http://localhost:8585/

echo "Verifying ActiveTransfer MWS UI ..."
curl -u Administrator:manage -s http://localhost:8585/webm.apps.tasks.admin.integration.mft.server.mgmt

echo "TEST SUCCESSFUL"
