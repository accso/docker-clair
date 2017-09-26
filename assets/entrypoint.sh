#!/bin/sh
echo "Relevant environment settings:"
echo "POSTGRESQL_USERNAME: ${POSTGRESQL_USERNAME}"
echo "POSTGRESQL_HOSTNAME: ${POSTGRESQL_HOSTNAME}"
echo "POSTGRESQL_PORT: ${POSTGRESQL_PORT}"

echo "Generating configuration file from template..."
mkdir -p /etc/clair
/usr/local/bin/dockerize -template /config.template:/etc/clair/config.yaml
cat /etc/clair/config.yaml
echo "Waiting for PostgreSQL server ${POSTGRESQL_HOSTNAME}:${POSTGRESQL_PORT} to come up..."
/usr/local/bin/dockerize -wait tcp://${POSTGRESQL_HOSTNAME}:${POSTGRESQL_PORT} \
			 /clair
