#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export is_instance_name=${is_instance_name:-default}

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MFTSupport --wait-for-cc

    export CC_WAIT=180
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes -e MAT_10.1_Server_Fix

    echo "Verifying instances ..."
    sagcc get inventory components -e "OSGI-IS_${is_instance_name}"

    echo "Start the instance ..."
    sagcc exec lifecycle components "OSGI-IS_${is_instance_name}" restart -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus "OSGI-IS_${is_instance_name}" -e ONLINE
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage -s http://localhost:5555/


echo "TEST SUCCESSFUL"
