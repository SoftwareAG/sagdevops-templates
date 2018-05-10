ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-server
ARG NODE_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node

# Get access to the node image
FROM $NODE_IMAGE as node

# Base CC server image
FROM $BASE_IMAGE as builder

ARG CC_INSTALLER=$CC_INSTALLER
ARG CC_INSTALLER_URL
ARG LICENSES_URL
ARG REPO_PRODUCT
ARG REPO_FIX
ARG REPO_HOST

WORKDIR $CC_HOME

# add all templates
ADD templates/ profiles/CCE/data/templates/composite/
# replace default scripts
ADD scripts/*.sh ./

# instead of bootstrapping node from $CC_INSTALLER
# Copy target node from the $NODE_IMAGE
COPY --from=node /opt/softwareag/ /opt/softwareag/

# configure repos and add licenses
# RUN SAG_HOME=$CC_HOME NODES=local $CC_HOME/provision.sh && ./init.sh
RUN $CC_HOME/provision.sh && ./init.sh

# default parameters
ONBUILD ARG RELEASE=$RELEASE
ONBUILD ARG REPO_PRODUCT=products
ONBUILD ARG REPO_FIX=fixes
ONBUILD ARG REPO_ASSET=assets

ONBUILD ADD . .
# do not run by default # ONBUILD RUN $CC_HOME/provision.sh

ENV REPO_PRODUCT=products
ENV REPO_FIX=fixes
ENV REPO_ASSET=assets

WORKDIR /src
