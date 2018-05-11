# Use $TAG to control release
ARG TAG=latest
# Use $BUILDER_IMAGE to control repo, e.g. private/public
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG

# Target image base image
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/centos:7

FROM $BUILDER_IMAGE as builder

ARG __ninja_mem_max=256

RUN $CC_HOME/provision.sh && ./test.sh

FROM $BASE_IMAGE

EXPOSE 4444 4445 4446 4447

# copy everything as is from the builder stage
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# basic entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
