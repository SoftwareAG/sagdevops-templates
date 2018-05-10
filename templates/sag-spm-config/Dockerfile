# Managed node image
# IMPORTANT: use image tag for target release
ARG NODE_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node:10.3

# Command Central builder image. Should be the latest available tag
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:10.3

# Target image base image
# IMPORTANT: for managed images MUST be the same as $NODE_IMAGE
# for unmanaged images can be any supported OS
ARG BASE_IMAGE=centos:7

# Get access to the node image
FROM $NODE_IMAGE as node

# Get access to the builder image
FROM $BUILDER_IMAGE as builder

# build arg for hello.name template parameter
ARG __hello_world=default
# runtime container init parameter
ENV HELLO_NAME=default

# Copy target node from the node image
# COPY --from=node /opt/softwareag /opt/softwareag

# Apply template.yaml with env.properties and run smoke tests
RUN $CC_HOME/provision.sh && ./test.sh

# Target image
FROM $BASE_IMAGE as main

# Define SAG_HOME in case we don't use base node image
ENV SAG_HOME=/opt/softwareag

# expose any ports from runtimes defined in the template.yaml
EXPOSE 8092

COPY --from=builder $SAG_HOME $SAG_HOME

# entrypoint scripts
ADD entrypoint.sh $SAG_HOME

ENTRYPOINT $SAG_HOME/entrypoint.sh
