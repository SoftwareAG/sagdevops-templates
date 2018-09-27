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

# TODO: integrate changes from
# http://svn.apama.com/um/branches/dev/BF-6295_Docker/prod/installation/docker/dockerfile/

ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Get access to the builder image
FROM $BUILDER_IMAGE as builder

ARG TEMPLATE=sag-um-server

# build arguments as template parameters
ARG __um_instance_name=default
ARG __um_instance_port=9000
ARG __um_realm=default
ARG __um_fixes=[]

# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/profiles/CCE/data/templates/composite/$TEMPLATE/test.sh && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE as default

# re-declare build arguments from builder stage!
ARG __um_instance_name=default
ARG __um_instance_port=9000
ARG __um_realm=default

ENV UM_HOME $SAG_HOME/UniversalMessaging
ENV UM_INSTANCE_NAME=$__um_instance_name

# Default realm name, can be customised by changing this line, or overriding this variable when running the image for the first time. After
# the image has been run once it is too late to change the realm name in subsequent derived images, as it gets baked into persistent
# configuration.
ENV UM_REALM=$__um_realm  						

# Extra properties to pass to the realm server, intended for settings that can only be configured at realm server startup. The default here
# is to ask it to start it without using low-latency mode (CORE_SPIN), but this environment variable can be overridden when running the image.
ENV SERVER_OPTS_EXTRA -DCORE_SPIN=false

# Path gives access to 'umctx' and 'java', classpath gives access to all UM libraries
ENV PATH=$PATH:$UM_HOME/:$JAVA_HOME/bin/
ENV CLASSPATH=$UM_HOME/lib/*

EXPOSE $__um_instance_port 8082 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR $UM_HOME

# HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 CMD "curl -f http://localhost:8092/spm/ || exit 1"
