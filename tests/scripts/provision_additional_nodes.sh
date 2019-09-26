case $TEMPLATE_ALIAS in
    sag-spm-boot-ssh)
      docker-compose build node-sshd
      docker-compose up -d node-sshd
      export NODES=node-sshd
      [ -z "$CC_INSTALLER" ] &&  CC_INSTALLER=cc-def-10.4-fix3-lnxamd64.sh
      PARAMS="nodes=$NODES os.credentials.key=SAGADMIN cc.installer=$CC_INSTALLER install.dir=/opt/softwareag spm.port=8093 ssh.port=22 $PARAMS"
      docker-compose exec -T cc bash -c "sagcc list inventory products --wait-for-cc"
      docker-compose exec -T cc bash -c "sagcc exec templates composite apply sag-cc-creds --sync-job -c 5 -e DONE \
              credentials.username=sagadmin \
              credentials.password=sagadmin \
              credentials.key=SAGADMIN"
      docker-compose exec -T cc bash -c "curl -L -o /opt/sagtools/profiles/CCE/data/installers/$CC_INSTALLER http://empowersdc.softwareag.com/ccinstallers/$CC_INSTALLER"
      ;;
    sag-spm-boot-local)
      export NODES=node-local
      export NODE=node-local
      [ -z "$CC_INSTALLER" ] &&  CC_INSTALLER=cc-def-10.4-fix3-lnxamd64.sh
      PARAMS="nodes=$NODES node=$NODE cc.installer=$CC_INSTALLER install.dir=/tmp/softwareag_local spm.port=8193 $PARAMS"
      docker-compose exec -T cc bash -c "curl -L -o /opt/sagtools/profiles/CCE/data/installers/$CC_INSTALLER http://empowersdc.softwareag.com/ccinstallers/$CC_INSTALLER"    
      ;;
     sag-db-sqlserver)
       echo sqlserver
       ;;
     sag-db-mysql)
      echo mysql
      ;;
     sag-db-oracle)
      echo oracle
      ;;
     *)
      echo "The template does not need additional host"
esac
