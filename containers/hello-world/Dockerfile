###############################################################################
#  Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

# template alias to apply
ARG TEMPLATE=sag-spm-config

# build-time template parameter: hello.world
ARG __hello_world=default

# run-time container init parameter
ENV HELLO_NAME=default

# Apply template.yaml, run smoke tests, cleanup
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/profiles/CCE/data/templates/composite/$TEMPLATE/test.sh && \
    $CC_HOME/cleanup.sh

# target image
FROM $BASE_IMAGE

# expose any ports from runtimes defined in the template.yaml
EXPOSE 8092 8093

COPY --from=builder --chown=1724:1724 $SAG_HOME $SAG_HOME

# entrypoint scripts
ADD entrypoint.sh $SAG_HOME

ENTRYPOINT $SAG_HOME/entrypoint.sh
