###############################################################################
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
###############################################################################
ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

# build arguments as template parameters for backed in default config
ARG __tc_fixes=[]
ARG __tc_tsa_port="9010"
ARG __tc_grp_port="9030"
ARG __tc_mgt_port="9040"
ARG __tc_memory_max="512"
ARG __tc_data_dir="/data/diskstore"
ARG __tc_backup_dir="/data/backup"
ARG __tc_logs_dir="stdout:"

ARG TEMPLATE=sag-tc-server

# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/profiles/CCE/data/templates/composite/$TEMPLATE/test.sh && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE as default

ARG __tc_tsa_port="9010"
ARG __tc_grp_port="9030"
ARG __tc_mgt_port="9040"
ARG __tc_data_dir="/data/diskstore"
ARG __tc_backup_dir="/data/backup"

# /data/diskstore will persist have persistent data  (FRS persistence for example); better not be on container filesystem !
ENV DISKSTORE_DIRECTORY "${__tc_data_dir}"
VOLUME $DISKSTORE_DIRECTORY

# /data/backup/ will receive backup data; it must go to a highly trustable volume mount !
ENV BACKUP_DIRECTORY "${__tc_backup_dir}"
VOLUME $BACKUP_DIRECTORY

# optional, path to tc-config.xml file to overwrite default
ENV CONFIG_FILE "$SAG_HOME/Terracotta/server/wrapper/conf/tc-config.xml"

# Optional, path to the license.key file to ovewrite default, if bundled
ENV LICENSE_FILE "$SAG_HOME/Terracotta/terracotta-license.key"

# default values for offheap, that you can override when starting your container with docker run -e OFFHEAP_MAX_SIZE=512g for example
ENV OFFHEAP_ENABLED "true"
ENV OFFHEAP_MAX_SIZE "1g"

# Expose the default server port, the default replication port, and the default management port
EXPOSE ${__tc_tsa_port} ${__tc_grp_port} ${__tc_mgt_port} 8092

# make the JVM aware of the container memory constraints, since JDK 8u131
# see https://blog.csanchez.org/2017/05/31/running-a-jvm-in-a-container-without-getting-killed
ENV JAVA_OPTS "-Dcom.tc.productkey.path=${LICENSE_FILE} -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"

# copy everything to make it a managed images
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

WORKDIR $SAG_HOME
ADD entrypoint.sh tc.custom.log4j.properties ./

# before starting the terracotta server, we update the tc-config.xml configuration file
ENTRYPOINT $SAG_HOME/entrypoint.sh
