#!/bin/sh -e
###############################################################################
#  Copyright  2013 - 2019 Software AG, Darmstadt, Germany and/or its licensors
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

TEMPLATE_ALIAS_LOCAL=$1
NUMBER_OF_NODES=${2:-0}
echo providing $NUMBER_OF_NODES additional SPM nodes and additional DB nodes for template $TEMPLATE_ALIAS_LOCAL
case $TEMPLATE_ALIAS_LOCAL in
    sag-spm-boot-ssh)
      echo "Provisioning additional host with  ssh server"
      docker-compose build node-sshd
      docker-compose up -d node-sshd
      export NODES=node-sshd
      [ -z "$CC_INSTALLER" ] &&  CC_INSTALLER=cc-def-10.4-fix3-lnxamd64.sh
      export PARAMS="nodes=$NODES os.credentials.key=SAGADMIN cc.installer=$CC_INSTALLER install.dir=/opt/softwareag spm.port=8093 ssh.port=22 $PARAMS "
      docker-compose exec -T cc bash -c "sagcc list inventory products --wait-for-cc"
      docker-compose exec -T cc bash -c "sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
              credentials.username=sagadmin \
              credentials.password=sagadmin \
              credentials.key=SAGADMIN"
      docker-compose exec -T cc bash -c "curl -L -o /opt/sagtools/profiles/CCE/data/installers/$CC_INSTALLER http://empowersdc.softwareag.com/ccinstallers/$CC_INSTALLER"
      export ENV_PREFIX="NODES=$NODES"
      ;;
    sag-spm-boot-local)
      echo "Provisioning empty local host"
      export NODES=node-local
      export NODE=node-local
      [ -z "$CC_INSTALLER" ] &&  CC_INSTALLER=cc-def-10.4-fix3-lnxamd64.sh
      export PARAMS="nodes=$NODES node=$NODE cc.installer=$CC_INSTALLER install.dir=/tmp/softwareag_local spm.port=8193 $PARAMS "
      docker-compose exec -T cc bash -c "curl -L -o /opt/sagtools/profiles/CCE/data/installers/$CC_INSTALLER http://empowersdc.softwareag.com/ccinstallers/$CC_INSTALLER"    
      export ENV_PREFIX="NODES=$NODES NODE=$NODE"
      ;;
    sag-db-sqlserver*)
       echo "Provisioning MS SQLserver"
       export PASSWORD=MaNaGe123
       docker-compose -f templates/${TEMPLATE_ALIAS_LOCAL}/docker-compose.yml up -d sqlserver
       export PARAMS="db.admin.username=sa db.admin.password=$PASSWORD db.host=sqlserver db.username=webm db.password=webm $PARAMS "
       ;;
    sag-db-mysql*)
       echo "Provisioning MYSQL server"
       export PASSWORD=root
       docker-compose -f templates/${TEMPLATE_ALIAS_LOCAL}/docker-compose.yml up -d mysql
       export PARAMS="db.admin.username=root db.admin.password=$PASSWORD db.host=mysql db.username=webm db.password=webm $PARAMS "
      ;;
    sag-db-db2)
       echo "Provisioning DB2 server"
       export PASSWORD=manage
       docker-compose -f templates/${TEMPLATE_ALIAS_LOCAL}/docker-compose.yml up --build -d db2
       export PARAMS="db.admin.username=db2inst1 db.admin.password=$PASSWORD db.host=db2 db.username=webm db.password=manage db.tablespace.dir=alabala $PARAMS "
      ;;

    sag-db-oracle*)
       echo "Provisioning ORACLE server"
       export PASSWORD=Passw0rd
       docker-compose up -d oracle
       export PARAMS="db.admin.username=system db.admin.password=oracle db.host=oracle db.username=webm db.password=webm $PARAMS "
      ;;
     *)
        if [ "$NUMBER_OF_NODES" -ne 0 ]
            then
                echo "provisioning $NUMBER_OF_NODES additional SPM nodes"
                docker-compose up -d dev$NUMBER_OF_NODES
                NODES="["
                for i in `seq 1 $NUMBER_OF_NODES`
                do 
                    NODES="${NODES}dev$i,"
                done
                NODES=${NODES: : -1}"]"
                #export PARAMS="nodes=$NODES"
                export ENV_PREFIX="NODES=$NODES "
        fi
      echo "The template $TEMPLATE_ALIAS_LOCAL does not need additional DB host"
esac

echo "PARAMS=$PARAMS"
echo "ENV_PREVIX=$ENV_PREFIX"
