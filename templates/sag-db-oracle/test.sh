#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container via $CC_SERVER ..."
    sagcc get inventory products -e DatabaseComponentConfigurator --wait-for-cc

    export CC_WAIT=60
    echo "Verifying fixes ..."
    sagcc get inventory fixes 
fi

echo "DONE testing"
