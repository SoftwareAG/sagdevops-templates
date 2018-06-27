ARG TAG=10.3
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE as builder

ARG __is_fixes=[]
ARG __is_instance_name=default

RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 5555 9999 8094 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

WORKDIR $SAG_HOME

# HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 CMD "curl -f localhost:8092/spm/ || exit 1"
