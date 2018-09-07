#!/bin/sh

$SAG_HOME/register.sh

echo "SPM process started. Waiting for services ..."
# wait until default.log comes up
while [  ! -f $SAG_HOME/profiles/SPM/logs/default.log ]; do
    tail $SAG_HOME/profiles/SPM/logs/wrapper.log
    sleep 5
done

echo "Waiting for HTTP stack ..."
until curl -s http://`hostname`:8092/ 
do 
    sleep 5
done

# this is our main container process

echo "SPM ONLINE is listening at http://`hostname`:8092/spm"
tail -f $SAG_HOME/profiles/SPM/logs/default.log
