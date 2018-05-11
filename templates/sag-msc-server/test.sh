#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MSC --wait-for-cc

    export CC_WAIT=60
    # echo "Verifying fixes ..."
    # sagcc get inventory fixes -e wMFix.integrationServer.Core

    echo "Verifying instances ..."
    sagcc get inventory components -e OSGI-IS_msc

    echo "Start the instance ..."
    sagcc exec lifecycle components OSGI-IS_msc start -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus OSGI-IS_msc -e ONLINE
    sagcc get monitoring runtimestatus integrationServer-msc -e ONLINE

    # echo "Verifying configs ..."
    # sagcc get configuration data OSGI-SPM COMMON-SYSPROPS -f text -e hello.world
fi

echo "TODO: Verifying product runtime ..."
curl Administrator:manage -s http://`hostname`:5555/

echo "DONE testing"
