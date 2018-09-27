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

# can be sag-msc-server, sag-is-server or a custom one
ARG TEMPLATE=sag-msc-server

ARG __is_fixes=[]
ARG __is_instance_name=default

# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/profiles/CCE/data/templates/composite/$TEMPLATE/test.sh && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 5555 9999 8094 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR $SAG_HOME
