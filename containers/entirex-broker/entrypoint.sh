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
function overwrite_license {
echo "Looking for license file ${EXX_LICENSE_KEY} in /licenses."
if [ -f /licenses/${EXX_LICENSE_KEY} ]; then
  echo "${EXX_LICENSE_KEY} found copy content to ${EXXDIR}/config/license.xml."
  cp /licenses/${EXX_LICENSE_KEY} ${EXXDIR}/config/license.xml
else
  echo "No ${EXX_LICENSE_KEY} in /licenses found."
fi
}

# Check if there is a customer specific attribute file ${EXX_ATTRIBUTE} 
# in the /configs directory, if there is one copy it to the right location. 
function overwrite_attribute {
echo "Looking for attribute file ${EXX_ATTRIBUTE} in /configs."
if [ -f /configs/${EXX_ATTRIBUTE} ]; then
  echo "${EXX_ATTRIBUTE} found copy content to ${EXXDIR}/config/etb/${ETBID}/etbfile."
  cp /configs/${EXX_ATTRIBUTE} ${EXXDIR}/config/etb/${ETBID}/etbfile
else
  echo "No ${EXX_ATTRIBUTE} in /configs found, using default."
fi
}

# Check if there is a customer specific certificates 
# in the /configs directory, if there is one copy it to the right location. 
function overwrite_certificates {
echo "Looking for ${EXX_KEY_FILE} in /configs."
if [ -f /configs/${EXX_KEY_FILE} ]; then
  echo "${EXX_KEY_FILE} found copy it to ${EXXDIR}/config/etb/${ETBID}."
  cp /configs/${EXX_KEY_FILE} ${EXXDIR}/config/etb/${ETBID}
else
  echo "No ${EXX_KEY_FILE} in /configs found, using default."
fi

echo "Looking for ${EXX_KEY_STORE} in /configs."
if [ -f /configs/${EXX_KEY_STORE} ]; then
  echo "${EXX_KEY_STORE} found copy it to ${EXXDIR}/config/etb/${ETBID}."
  cp /configs/${EXX_KEY_STORE} ${EXXDIR}/config/etb/${ETBID}
else
  echo "No ${EXX_KEY_STORE} in /configs found, using default."
fi

echo "Looking for ${EXX_TRUST_STORE} in /configs."
if [ -f /configs/${EXX_TRUST_STORE} ]; then
  echo "${EXX_TRUST_STORE} found copy it to ${EXXDIR}/config/etb/${ETBID}."
  cp /configs/${EXX_TRUST_STORE} ${EXXDIR}/config/etb/${ETBID}
else
  echo "No ${EXX_TRUST_STORE} in /configs found, using default."
fi
}

overwrite_license
overwrite_attribute
overwrite_certificates

# Setting necessary environment variables
export PATH="${EXXDIR}/bin:${PATH}"
export EXXVERS="."
export LD_LIBRARY_PATH="${EXXDIR}/lib:${LD_LIBRARY_PATH}"

# Starting etbnuc and sending it into the background.
${EXXDIR}/bin/etbnuc -a ${EXXDIR}/config/etb/${ETBID}/etbfile &

# Wait forever until container shuts down
wait

exit 0
