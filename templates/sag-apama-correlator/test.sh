#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e PAMServer --wait-for-cc

    export CC_WAIT=20
    export id="Apama-correlator-${__apama_instance_name:-default}"
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes

    echo "Verifying instances ..."
    sagcc get inventory components -e $id

    echo "Start the instance ..."
    sagcc exec lifecycle components $id start -e "DONE|is already started" --sync-job -c 3

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus $id -e ONLINE

    echo "Verifying configs ..."
    sagcc get configuration data $id APAMA-ARGS -f text -e persistence_store.db
    sagcc get configuration data $id APAMA-ENVVAR -f text -e foobar
    sagcc get configuration data $id APAMA-ENGINE-CONNECT-localhost-15905 -f json -e c1
    sagcc get configuration data $id APAMA-PROP-OVERRIDES -f text -e remote.example.com
fi

echo "TODO: Verifying product runtime and the HelloWorld app ..."
# curl -s http://`hostname`:15904/

echo "DONE testing"
