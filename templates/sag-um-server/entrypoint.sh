#!/bin/sh

# if managed image (SPM is present)
if [ -d $SAG_HOME/profiles/SPM/bin ]; then
    # self-register
    $SAG_HOME/profiles/SPM/bin/register.sh
    # start SPM in background
    $SAG_HOME/profiles/SPM/bin/startup.sh
fi

# Define all of the usual realm server options, except:
#     The realm name which is parameterised from the environment
#     Logging which goes to stdout in order to be captured by Docker's logging system
#     SERVER_OPTS_EXTRA from the environment
SERVER_OPTS="-DDATADIR=server/$INSTANCE/data
             -DREALM=$REALM
             -DSERVERDIR=server/$INSTANCE
             -DADAPTER_0=nhp://0.0.0.0:$UM_PORT
             -DLICENCE_DIR=server/license/
             -DLICENCE_FILE=licence.xml
             -DLOGFILE=/dev/stdout
             -Djavax.net.ssl.trustStore=server/$INSTANCE/bin/nirvanacacerts.jks
             -Djavax.net.ssl.trustStorePassword=nirvana
             -Djavax.net.ssl.keyStore=server/$INSTANCE/bin/server.jks
             -Djavax.net.ssl.keyStorePassword=nirvana
             -Djava.protocol.handler.pkgs=com.sun.net.ssl.internal.www.protocol
             -Dcom.sun.management.jmxremote
             -Djava.library.path=lib/
             -DLOGLEVEL=4
             -XX:MaxDirectMemorySize=1G
             $SERVER_OPTS_EXTRA"

# The first time the server is run, the data will be a total blank slate. We can live with that, except we want to restore the default *@*
# full ACL.
if [[ ! -e server/$INSTANCE/data ]]
then
	echo '*@*' > server/$INSTANCE/bin/secfile.conf
	SERVER_OPTS="$SERVER_OPTS 
	-DSECURITYFILE=server/$INSTANCE/bin/secfile.conf"
fi

####
# Starting the realm server in the container in foreground
####
java $SERVER_OPTS com.pcbsys.nirvana.server.Server $@ &

# Ensure that 'docker stop' performs a clean server shutdown
export SERVER_PID=$!
trap "rm server/$INSTANCE/data/RealmServer.lck; wait $SERVER_PID" SIGTERM
wait $SERVER_PID