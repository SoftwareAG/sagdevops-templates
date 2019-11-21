#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export is_instance_name=${is_instance_name:-default}
	
    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MFTSupport --wait-for-cc

    export CC_WAIT=180

    echo "Restart the instance ..."
    sagcc exec lifecycle components "OSGI-IS_${is_instance_name}" restart -e DONE --sync-job

    echo "Verifying instance status ..."
    sagcc get monitoring runtimestatus "integrationServer-${is_instance_name}" -e ONLINE

    echo "Verifying WmMFT status ..."
    sagcc get monitoring runtimestatus "OSGI-IS_${is_instance_name}-WmMFT" -e ONLINE
	
	echo "Verifying configuration"
	sagcc get configuration instances OSGI-IS_${is_instance_name}-WmMFT -e COMMON-PORTS-MFT -w 1
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage http://localhost:${__mft_port_number}/WebInterface/login.html

echo "TEST SUCCESSFUL"
