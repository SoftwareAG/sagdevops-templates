# custom internal builder image that includes
# 1. internal licenses
# 2. default templates

ARG BASE_IMAGE
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

WORKDIR /src
