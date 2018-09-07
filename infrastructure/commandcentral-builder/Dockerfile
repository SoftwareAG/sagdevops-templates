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

ARG CC_SERVER_IMAGE
ARG CC_NODE_IMAGE

# Get access to the node image
FROM $CC_NODE_IMAGE as node

# Base CC server image
FROM $CC_SERVER_IMAGE as builder

ARG LICENSES_URL
ARG REPO_PRODUCT
ARG REPO_FIX
ARG REPO_HOST
ARG REPO_PRODUCT_URL
ARG REPO_FIX_URL
ARG REPO_CREDS
ARG REPO_USERNAME
ARG REPO_PASSWORD

WORKDIR $CC_HOME

# USER 1724

# add all templates
ADD templates/ profiles/CCE/data/templates/composite/
# replace default scripts
ADD scripts/*.sh ./

# Copy target node from the $NODE_IMAGE
COPY --from=node /opt/softwareag/ /opt/softwareag/

# configure repos and add licenses
RUN $CC_HOME/provision.sh

# default parameters
ONBUILD ARG RELEASE=$RELEASE
ONBUILD ARG REPO_PRODUCT=$REPO_PRODUCT
ONBUILD ARG REPO_FIX=$REPO_FIX
ONBUILD ARG REPO_HOST=
ONBUILD ADD . .
# do not run by default # ONBUILD RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

WORKDIR /src
