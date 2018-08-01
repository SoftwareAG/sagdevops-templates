ARG TAG=10.3
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE

ARG __exx_server_instance_name=CRpcSrv
ARG __exx_server_fixes=[]

RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 1971 3096 8092

COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# entrypoint script
ADD entrypoint.sh $SAG_HOME/

WORKDIR $SAG_HOME
ENTRYPOINT $SAG_HOME/entrypoint.sh
