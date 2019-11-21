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
ARG NODE_IMAGE

FROM $NODE_IMAGE as node
FROM $BUILDER_IMAGE as builder

WORKDIR $CC_HOME

USER 1724

# add all templates
ADD --chown=1724:1724 templates/ profiles/CCE/data/templates/composite/
# replace default scripts
# ADD --chown=1724:1724 scripts/*.sh ./

# add licenses.zip, if any
ADD --chown=1724:1724 licenses/*.zip ./licenses/

# Copy target node from the $NODE_IMAGE
COPY --from=node --chown=1724:1724 /opt/softwareag/ /opt/softwareag/

# configure repos and add licenses
RUN $CC_HOME/provision.sh

ONBUILD ADD --chown=1724:1724 . .

WORKDIR /src
