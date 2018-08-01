#!/bin/sh

if [ -f $SAG_HOME/register.sh ]; then
    $SAG_HOME/register.sh
fi

# you can simply run main product run in foreground
# $SAG_HOME/profiles/IS_$INSTANCE_NAME/bin/console.sh
# or do this...

IS_INSTANCE_NAME=${IS_INSTANCE_NAME:-default}

# echo "Remove old logs"
# rm -rf $SAG_HOME/profiles/IS_$IS_INSTANCE_NAME/logs/*.log

# or can start in background
$SAG_HOME/profiles/IS_$IS_INSTANCE_NAME/bin/startup.sh

echo "IS process started. Waiting ..."
# wait until IS server.log comes up
while [  ! -f $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log ]; do
    # tail $SAG_HOME/profiles/IS_$INSTANCE_NAME/logs/wrapper.log
    sleep 5
done

echo "IS process successfully started. Waiting for HTTP stack ..."
until curl -u Administrator:manage -s http://`hostname`:5555/ 
do 
    sleep 5
    tail $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log
done

# this is our main container process

echo "Integration Server is ONLINE at http://`hostname`:5555/"

tail -f $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log
