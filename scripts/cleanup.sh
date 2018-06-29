#!/bin/sh

echo "Cleaning up $SAG_HOME ..."
cd $SAG_HOME

echo 'Disk usage before cleaning:'
du -h -d 2

echo "Removing Update Manager, fixes metadata and backups ..."
rm -fr SAGUpdateManager/

echo "Removing Installer but keep install/products metadata ..."
rm -fr install/repo install/logs install/jars install/bpms install/etc
rm -f sagProducts.xml sagMetadata.xml p2.index

echo "Removing Licenses and doc ..."
rm -fr Licenses/ _documentation/

echo "Removing log files ..."
rm -f `find ./ -name *.log`

echo "Removing Common ..."
# rm -rf common/db/
# rm -rf common/runtime/install/
# rm -rf common/runtime/agent/

echo "Removing Java ..."
rm -fr jvm/

echo 'Disk usage after cleaning:'
du -h -d 2
