###############################################################################
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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
###############################################################################

ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

# can be sag-is-mft or a custom one
ARG TEMPLATE=sag-is-mft-test
ARG __fmt_fixes=[]
# can be only MSC or MSC and layer product, ex [MSC,WmSAP] 
ARG __mft_products=[]

# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 5555 9999 9100 9102

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

#COPY --chown=1724:1724  properties.cnf $SAG_HOME/IntegrationServer/instances/default/packages/WmMFT/config/
COPY --chown=1724:1724  assets/config/* $SAG_HOME/IntegrationServer/instances/default/packages/WmMFT/config/
COPY --chown=1724:1724  assets/resources/builtin $SAG_HOME/IntegrationServer/instances/default/packages/WmMFT/resources/

# Current working directory for all commands. This is where the MSC installation is copied to within the image.
WORKDIR $SAG_HOME
