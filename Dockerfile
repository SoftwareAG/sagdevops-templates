ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-server
ARG NODE_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node

# Get access to the node image
FROM $NODE_IMAGE as node

# Base CC server image
FROM $BASE_IMAGE as builder

ARG LICENSES_URL
ARG REPO_PRODUCT
ARG REPO_FIX
ARG REPO_HOST

#ENV REPO_PRODUCT=$REPO_PRODUCT
#ENV REPO_FIX=$REPO_FIX
#ENV REPO_HOST=$REPO_HOST

WORKDIR $CC_HOME

# add all templates
ADD templates/ profiles/CCE/data/templates/composite/
# replace default scripts
ADD scripts/*.sh ./

# instead of bootstrapping node from $CC_INSTALLER
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
