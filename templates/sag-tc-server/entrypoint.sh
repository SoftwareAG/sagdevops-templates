#!/bin/bash

# Command Central management agent support
if [ -f $SAG_HOME/register.sh ]; then
    $SAG_HOME/register.sh
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "config file $CONFIG_FILE is missing"
    exit 20
fi

if [ ! -f "$LICENSE_FILE" ]; then
    echo "license file $LICENSE_FILE is missing"
    exit 30
fi

# Creating the disktore directory, if not present.
if [ ! -d "$DISKSTORE_DIRECTORY" ]; then
    mkdir -p $DISKSTORE_DIRECTORY
fi

# Creating the backup directory, if not present.
if [ ! -d "$BACKUP_DIRECTORY" ]; then
    mkdir -p $BACKUP_DIRECTORY
fi

# chown in a volume can be problematic : if the volume is a nfs mount, maybe root can't (and don't need to) chown it for example...
test -w $DISKSTORE_DIRECTORY || (echo "$DISKSTORE_DIRECTORY not writeable by sagadmin, trying to chown it" && chown -R sagadmin:sagadmin $DISKSTORE_DIRECTORY)

# Replacing the value of OFFHEAP_MAX_SIZE as passed in via environment variable.
sed -i -r 's/1g/'$OFFHEAP_MAX_SIZE'/' $CONFIG_FILE

# Changing permission for sagadmin home directory.
# chown -R sagadmin:sagadmin $SAG_HOME

cd $SAG_HOME/Terracotta/server
bin/start-tc-server.sh -f $CONFIG_FILE
#  -n $HOSTNAME
