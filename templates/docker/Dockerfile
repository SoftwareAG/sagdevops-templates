ARG TAG=10.3
FROM daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG as builder
ARG TEMPLATE=sag-spm-config
RUN $CC_HOME/provision.sh $TEMPLATE && $CC_HOME/cleanup.sh
FROM daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos
ARG PORT=8092
ARG ENTRYPOINT=profiles/SPM/bin/console.sh
ENV ENTRYPOINT $ENTRYPOINT
EXPOSE $PORT
COPY --from=builder $SAG_HOME/ $SAG_HOME/
WORKDIR $SAG_HOME
ENTRYPOINT [ "sh", "-c", "$ENTRYPOINT" ]
