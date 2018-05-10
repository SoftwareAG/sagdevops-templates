
ARG __um_instance_name=default
ARG __um_instance_port=9000
ARG __um_realm=default

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

RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

ENV SAG_HOME=/opt/softwareag
ENV JAVA_HOME=$SAG_HOME/jvm/jvm/
ENV JRE_HOME=$SAG_HOME/jvm/jvm/jre/

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

EXPOSE $__um_instance_port 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR $UM_HOME

# Remove state from the the installation to give you a 'clean slate' w.r.t licensing, keys, configuration and state
# RUN rm -f `find $UM_HOME/ -name *.jks`; rm -rf $UM_HOME/server/license/; rm -rf $UM_HOME/server/$INSTANCE_NAME/data/
