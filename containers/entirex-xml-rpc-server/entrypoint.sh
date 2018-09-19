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

#!/bin/bash

# Check if there is a customer specific license file ${EXX_LICENSE_KEY} in the /licenses directory, 
# if there is one copy the content to ${EXXDIR}/config/license.xml. 
echo "Looking for license file ${EXX_LICENSE_KEY} in /licenses."
if [ -f /licenses/${EXX_LICENSE_KEY} ]; then
  echo "${EXX_LICENSE_KEY} found copy content to ${EXXDIR}/config/license.xml."
  cp /licenses/${EXX_LICENSE_KEY} ${EXXDIR}/config/license.xml
else
  echo "No ${EXX_LICENSE_KEY} in /licenses found."
  echo "Using default ${EXXDIR}/config/license.xml"
fi

# Clean up function to shutdown RPC server
function clean_up {
    sleep 5
    # Sending Java signal 1 TO PID 5 which is always the java process
    kill -1 5
    sleep 5
    exit 0
}


# Trap various signals to clean up the environment
trap clean_up EXIT SIGHUP SIGINT SIGTERM QUIT


# Starting EntireX RPC Server for XML/SOAP and sending it into the background.
$JAVA_HOME/bin/java -classpath "$EXXDIR/classes/entirex.jar:$EXXDIR/../common/lib/saglic.jar:$SAG_HOME/WS-Stack/lib/wsstack-client.jar" "-Dentirex.license.location=$EXXDIR/config/license.xml" com.softwareag.entirex.xml.rt.XMLRPCServer -p /configs/$EXX_XML_SERVER_CONFIGURATION -c /configs/$EXX_XML_SERVER_MAPPING $* &


# Wait forever until container shuts down
wait


exit 0