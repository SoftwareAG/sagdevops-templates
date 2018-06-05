#!/bin/sh

echo "Cleaning up $SAG_HOME ..."
cd $SAG_HOME

echo 'Disk usage before cleaning:'
du -h -d 2

echo "Remove Update Manager, fixes metadata and backups ..."
rm -fr SAGUpdateManager/

echo "Remove Installer but keep install/products metadata ..."
rm -fr install/repo install/logs install/jars install/bpms install/etc


echo "Remove Licenses and doc ..."
rm -fr Licenses/
rm -fr _documentation/

echo "Remove log files ..."
rm -f `find ./ -name *.log`

echo "Common ..."
rm -rf common/src/
# rm -rf common/db/
# rm -rf common/runtime/install/
# rm -rf common/runtime/agent/

echo "Remove Java ..."
rm -fr jvm/

echo 'Disk usage after cleaning:'
du -h -d 2
