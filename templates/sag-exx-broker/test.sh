#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export __exx_broker_instance_name=${__exx_broker_instance_name:-ETB002}

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e EntireXBroker --wait-for-cc

    export CC_WAIT=60
    echo "Verifying fixes ..."
    sagcc get inventory fixes

    echo "Verifying instances ..."
    sagcc get inventory components -e EntireXBroker-${__exx_broker_instance_name}

    echo "Start the instance ..."
    sagcc exec lifecycle components EntireXBroker-${__exx_broker_instance_name} start -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus EntireXBroker-${__exx_broker_instance_name} -e ONLINE

    # echo "Verifying configs ..."
    # sagcc get configuration data EntireXBroker-${__exx_broker_instance_name} BROKER-PORTS -f text -e 7722
fi

echo "Verifying product runtime ..."
echo "TODO:"

echo "DONE testing"
