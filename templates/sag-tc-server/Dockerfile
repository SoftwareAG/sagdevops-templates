ARG TAG=latest
# Use $BUILDER_IMAGE to control release
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG
# Target image base image
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE as builder

# build arguments as template parameters for backed in default config
ARG __tc_fixes=[]
# ARG __tc_tsa_port="9010"
# ARG __tc_grp_port="9030"
# ARG __tc_mgt_port="9040"
# ARG __tc_memory_max="512"
ARG __tc_data_dir="/data/diskstore"
ARG __tc_backup_dir="/data/backup"
ARG __tc_logs_dir="stdout:"

# provision, unit test and default cleanup
RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE as default

ENV SAG_HOME=/opt/softwareag
# TODO: should be in the base image! adding the user sagadmin (1724:1724 for users convention), to not run the server as root
RUN groupadd -g 1724 sagadmin && adduser -d $SAG_HOME -s /bin/bash -g 1724 -r sagadmin
USER sagadmin

# /data/diskstore will persist have persistent data  (FRS persistence for example); better not be on container filesystem !
ENV DISKSTORE_DIRECTORY "/data/diskstore"
VOLUME $DISKSTORE_DIRECTORY

# /data/backup/ will receive backup data; it must go to a highly trustable volume mount !
ENV BACKUP_DIRECTORY "/data/backup"
VOLUME $BACKUP_DIRECTORY

# optional, path to tc-config.xml file to overwrite default
ENV CONFIG_FILE "$SAG_HOME/Terracotta/server/wrapper/conf/tc-config.xml"

# Optional, path to the license.key file to ovewrite default, if bundled
ENV LICENSE_FILE "$SAG_HOME/Terracotta/terracotta-license.key"

# default values for offheap, that you can override when starting your container with docker run -e OFFHEAP_MAX_SIZE=512g for example
ENV OFFHEAP_ENABLED "true"
ENV OFFHEAP_MAX_SIZE "1g"

# Expose the default server port, the default replication port, and the default management port
EXPOSE 9010 9030 9040

# make the JVM aware of the container memory constraints, since JDK 8u131
# see https://blog.csanchez.org/2017/05/31/running-a-jvm-in-a-container-without-getting-killed
ENV JAVA_OPTS "-Dcom.tc.productkey.path=${LICENSE_FILE} -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"

WORKDIR $SAG_HOME
ADD entrypoint.sh tc.custom.log4j.properties ./

# copy everything to make it a managed images
COPY --from=builder --chown=1724:1724 $SAG_HOME ./

# before starting the terracotta server, we update the tc-config.xml configuration file
ENTRYPOINT $SAG_HOME/entrypoint.sh
