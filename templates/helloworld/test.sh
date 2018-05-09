#!/bin/sh -e

if [ ! -z $CC_SERVER ]; then
    echo "Verifying managed container ..."
    sagcc list inventory products $NODES -e SPM --wait-for-cc

    export CC_WAIT=0
    echo "Verifying fixes ..."
    sagcc list inventory fixes $NODES -e wMFix.SPM

    echo "Verifying instances ..."
    sagcc list inventory components $NODES -e OSGI-SPM

    echo "Verifying status ..."
    sagcc list monitoring runtimestatus $NODES OSGI-SPM -e ONLINE
    sagcc list monitoring runtimestatus $NODES OSGI-SPM-ENGINE -e ONLINE

    echo "Verifying configs ..."
    sagcc list configuration data $NODES OSGI-SPM COMMON-JAVASYSPROPS -f text -e hello.world
    sagcc list configuration data $NODES OSGI-SPM-ENGINE com.softwareag.platform.management.common.monitoring.BasicMonitoringService -f text -e "com.softwareag.plm.spm.monitoring.poll.interval.seconds,15"
fi

echo "Verifying product runtime ..."
curl -u Administrator:manage -H Accept:text http://node:8092/spm/inventory/products

echo "DONE testing"
