#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
	export mft.port.number= 4080
	export mft.port.name= ATS_HTTP
    export CC_SERVER=http://localhost:8092/spm
    export is_instance_name=${is_instance_name:-default}
	
	
    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MFTSupport --wait-for-cc

    export CC_WAIT=180

    echo "Verifying instances ..."
    sagcc get inventory components -e "OSGI-IS_${is_instance_name}"

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus "OSGI-IS_${is_instance_name}" -e ONLINE
	
	echo "Verifying configuration"
	sagcc get configuration data OSGI-IS_${is_instance_name}-WmMFT COMMON-PORTS-MFT${mft.port.name}
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage HTTP://localhost:${mft.port.number}/WebInterface/login.html

echo "TEST SUCCESSFUL"
