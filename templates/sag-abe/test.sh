#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e acdl --wait-for-cc

    echo "Verifying fixes ..."
    sagcc get inventory fixes 
fi

echo "Verifying product runtime ..."
build.sh

echo "DONE testing"
