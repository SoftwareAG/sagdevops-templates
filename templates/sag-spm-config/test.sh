#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e SPM --wait-for-cc

    export CC_WAIT=5
    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.SPM

    echo "Verifying instances ..."
    sagcc get inventory components -e OSGI-SPM

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus OSGI-SPM -e ONLINE
    sagcc get monitoring runtimestatus OSGI-SPM-ENGINE -e ONLINE

    echo "Verifying configs ..."
    sagcc get configuration data OSGI-SPM COMMON-JAVASYSPROPS -f text -e hello.world
    sagcc get configuration data OSGI-SPM-ENGINE com.softwareag.platform.management.common.monitoring.BasicMonitoringService -f text -e "15"
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage -H Accept:text http://localhost:8092/spm/inventory/products

echo "DONE testing"
