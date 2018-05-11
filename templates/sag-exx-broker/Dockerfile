# Command Central docker builder image
# Use $TAG to control release
ARG TAG=latest
# Use $BUILDER_IMAGE to control repo, e.g. private/public
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG

# Target image base image
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/centos:7

FROM $BASE_IMAGE

#RUN groupadd sag && useradd sag -g sag -d /opt/softwareag -s /bin/bash -M
#USER sag

RUN $CC_HOME/provision.sh

ENV EXXDIR=$SAG_HOME/EntireX

# expose any ports from runtimes defined in the template.yaml
EXPOSE 1971

# entrypoint scripts
ADD entrypoint.sh $SAG_HOME/

ENTRYPOINT $SAG_HOME/entrypoint.sh
