#!/bin/sh
#*******************************************************************************
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
#*******************************************************************************

if [ -f $SAG_HOME/register.sh ]; then
    $SAG_HOME/register.sh
fi

UM_INSTANCE_NAME=${UM_INSTANCE_NAME:-default}
UM_REALM=${UM_REALM:-default}
UM_INSTANCE_PORT=${UM_INSTANCE_PORT:-9000}

# Define all of the usual realm server options, except:
#     The realm name which is parameterised from the environment
#     Logging which goes to stdout in order to be captured by Docker's logging system
#     SERVER_OPTS_EXTRA from the environment
SERVER_OPTS="-DDATADIR=server/$UM_INSTANCE_NAME/data
             -DREALM=$UM_REALM
             -DSERVERDIR=server/$UM_INSTANCE_NAME
             -DADAPTER_0=nhp://0.0.0.0:$UM_INSTANCE_PORT
             -DLICENCE_DIR=${UM_HOME}/server/templates
             -DLICENCE_FILE=licence.xml
             -DLOGFILE=/dev/stdout
             -Djavax.net.ssl.trustStore=server/$UM_INSTANCE_NAME/bin/nirvanacacerts.jks
             -Djavax.net.ssl.trustStorePassword=nirvana
             -Djavax.net.ssl.keyStore=server/$UM_INSTANCE_NAME/bin/server.jks
             -Djavax.net.ssl.keyStorePassword=nirvana
             -Djava.protocol.handler.pkgs=com.sun.net.ssl.internal.www.protocol
             -Dcom.sun.management.jmxremote
             -Djava.library.path=lib/
             -DLOGLEVEL=4
             -XX:MaxDirectMemorySize=1G
             $SERVER_OPTS_EXTRA"

# The first time the server is run, the data will be a total blank slate. We can live with that, except we want to restore the default *@*
# full ACL.
if [[ ! -e server/$UM_INSTANCE_NAME/data ]]
then
    mkdir server/$UM_INSTANCE_NAME/bin
	echo '*@*' > server/$UM_INSTANCE_NAME/bin/secfile.conf
	SERVER_OPTS="$SERVER_OPTS -DSECURITYFILE=server/$UM_INSTANCE_NAME/bin/secfile.conf"
fi

####
# Starting the realm server in the container in foreground
####
java $SERVER_OPTS com.pcbsys.nirvana.server.Server $@ &

# Ensure that 'docker stop' performs a clean server shutdown
export SERVER_PID=$!
trap "rm server/$UM_INSTANCE_NAME/data/RealmServer.lck; wait $SERVER_PID" SIGTERM
wait $SERVER_PID
