#!/bin/sh

###
# default entrypoint script
###

$SAG_HOME/register.sh

echo "SPM process started. Waiting for services ..."
# wait until default.log comes up
while [  ! -f $SAG_HOME/profiles/SPM/logs/default.log ]; do
    tail $SAG_HOME/profiles/SPM/logs/wrapper.log
    sleep 5
done

echo "Waiting for SPM ..."
until curl -s http://`hostname`:8092/ 
do 
    sleep 5
done

echo "SPM is ONLINE at http://`hostname`:8092/spm"

# echo "Starting managed runtimes ..."
# sagcc exec lifecycle components OSGI-NINJA_default start -e DONE --sync-job -s http://`hostname`:8092/spm

# this is our main container process
tail -f $SAG_HOME/profiles/SPM/logs/default.log
