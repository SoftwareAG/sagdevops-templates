#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e NUMRealmServer --wait-for-cc

    export CC_WAIT=5
    # echo "Verifying fixes ..."
    # sagcc get inventory fixes -e wMFix.NUMRealmServer

    echo "Verifying instances ..."
    sagcc get inventory components -e Universal-Messaging-default

    echo "Start the instance ..."
    sagcc exec lifecycle components Universal-Messaging-default start  -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus Universal-Messaging-default -e ONLINE -w 60

    # echo "Verifying configs ..."
    # sagcc get configuration data OSGI-SPM COMMON-SYSPROPS -f text -e hello.world
fi

echo "TODO: Verifying product runtime ..."
# How?

echo "DONE testing"
