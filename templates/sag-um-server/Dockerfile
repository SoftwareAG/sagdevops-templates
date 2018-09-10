# Command Central docker builder image
# Use $TAG to control release
ARG TAG=latest
ARG RELEASE=
# Use $BUILDER_IMAGE to control repo, e.g. private/public
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG

# Target image base image
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

# Get access to the builder image
FROM $BUILDER_IMAGE as builder

# build arguments as template parameters
ARG __um_instance_name=default
ARG __um_instance_port=9000
ARG __um_realm=default
ARG __um_fixes=[]

# provision and unit test
RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE as default

ENV SAG_HOME=/opt/softwareag

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
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR $UM_HOME

HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 CMD [ "curl localhost:8092/spm/" ]
