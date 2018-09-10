#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e TES --wait-for-cc

    export CC_WAIT=60
    # echo "Verifying fixes ..."
    # sagcc get inventory fixes -e wMFix.TES

    echo "Verifying instances ..."
    sagcc get inventory components -e TES-default

    echo "Start the instance ..."
    sagcc exec lifecycle components TES-default start -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus TES-default -e ONLINE

    # echo "Verifying configs ..."
    # sagcc get configuration data OSGI-SPM COMMON-SYSPROPS -f text -e hello.world
fi

echo "Verifying product runtime ..."
curl http://localhost:9010/config

echo "DONE testing"
