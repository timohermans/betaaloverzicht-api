#!/bin/bash

echo "loading environment variables from .env"
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
echo "environment loaded"

compose_file=${1:-docker-compose.yml}

echo "using ${compose_file} compose file (supply an argument to script to change compose file)"

cd scripts

function query() {
  value=$(docker-compose -f ../$compose_file exec betaaloverzichtdb psql -U $POSTGRES_USER -d $POSTGRES_DB -c "$1")
}

docker-compose -f ../$compose_file exec betaaloverzichtdb psql -U $POSTGRES_USER -d $POSTGRES_DB -c "create schema if not exists db; create table if not exists db.migrations (id serial primary key, name varchar(255) not null);"

for sql_file in *.sql;
do
  query "select name from db.migrations where name = '${sql_file}'"
  if [[ "$value" == *"0 rows"* ]]; 
  then
    echo "going to execute ${sql_file}"
    docker-compose -f ../$compose_file exec betaaloverzichtdb psql -U $POSTGRES_USER -d $POSTGRES_DB -f /scripts/${sql_file}
    query "insert into db.migrations (name) values ('${sql_file}');"
  else
    echo "${sql_file} already migrated"
  fi
done

echo