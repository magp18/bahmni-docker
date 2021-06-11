#!/bin/bash

set -eu

function create_user_and_database() {
	local database=$1
	local user=$2
	local password=$3
	echo "  Creating 'openIMIS' user and database..."
	psql -v ON_ERROR_STOP=1 --username postgres postgres <<-EOSQL
	    CREATE USER $user WITH UNENCRYPTED PASSWORD '$password';
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
EOSQL
}

create_user_and_database ${OPENIMIS_DB_NAME} ${OPENIMIS_DB_USER} ${OPENIMIS_DB_PASSWORD}

psql -U ${OPENIMIS_DB_USER} -d ${OPENIMIS_DB_NAME} < /docker-entrypoint-initdb.d/db/openIMIS_base.sql
