ARG __is_fixes=[]

# Command Central docker builder image
# Use $TAG to control release
ARG TAG=latest
# Use $BUILDER_IMAGE to control repo, e.g. private/public
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG

# Target image base image
# IMPORTANT: for managed images MUST be the same as $NODE_IMAGE
# for unmanaged images can be any supported OS
ARG BASE_IMAGE=centos:7

FROM $BUILDER_IMAGE as builder

RUN $CC_HOME/provision.sh && ./test.sh

FROM $BASE_IMAGE

ENV SAG_HOME=/opt/softwareag
ENV JAVA_HOME=$SAG_HOME/jvm/jvm/
ENV JRE_HOME=$SAG_HOME/jvm/jvm/jre/

EXPOSE 5555 9999 8094 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
