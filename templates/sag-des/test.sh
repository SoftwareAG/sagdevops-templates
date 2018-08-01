#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e "DEV" --wait-for-cc

    export CC_WAIT=10
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes
    # -e wMFix.DEV ???

    echo "Verifying inventory ..."
    sagcc get inventory components -e "-DigitalEventServices"
    id=`sagcc get inventory components properties=id includeHeaders=false | grep "OSGI-IS_default-DigitalEventServices"`
    echo "Component id: $id"

    echo "Verifying configs for $id ..."
    sagcc get configuration types $id
    sagcc get configuration instances $id properties=id -e UniversalMessaging
    sagcc get configuration data $id UniversalMessaging -f json -e "UniversalMessaging service"
fi

# echo "TODO: Verifying product runtime ..."

echo "DONE testing"
