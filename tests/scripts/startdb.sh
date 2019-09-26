export COMPOSE_FILE=tests/databases/
export DB_NAME=$1
export PASSWORD=Passw0rd
case $DB_NAME in
  mssql)
      docker-compose up -d mssql
      ;;
  mysql)
      docker-compose up -d mysql
      ;;
  oracle)
      docker-compose up -d oracle
      ;;
  *)
      echo "not supported database or wrong parameter"
      exit 1
esac
