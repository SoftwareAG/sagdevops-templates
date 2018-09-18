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

ARG TEMPLATE=sag-abe

# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/profiles/CCE/data/templates/composite/$TEMPLATE/test.sh && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

ENV ABE_HOME=$SAG_HOME/common/AssetBuildEnvironment
ENV CC_CLI_HOME=$SAG_HOME/CommandCentral/client
ENV PATH=$PATH:$ABE_HOME/bin:$CC_CLI_HOME/bin

# output folder
ENV BUILD_OUTPUT_DIR=/src/build/assets/
# build number for assets
ENV BUILD_NUMBER=1

COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

WORKDIR /src

# TODO: set global properties in $ABE_HOME/master_build/build.properties
# shell form of CMD to use env vars
# CMD build.sh -Dbuild.source.dir=/src/ -Dbuild.output.dir=${BUILD_OUTPUT_DIR} -Dbuild.number=${BUILD_NUMBER}

CMD build.sh
