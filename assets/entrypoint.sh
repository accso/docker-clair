#!/bin/sh
echo "Relevant environment settings:"
echo "POSTGRESQL_USERNAME: ${POSTGRESQL_USERNAME}"
echo "POSTGRESQL_HOSTNAME: ${POSTGRESQL_HOSTNAME}"
echo "POSTGRESQL_PORT: ${POSTGRESQL_PORT}"
echo "POSTGRESQL_TIMEOUT: ${POSTGRESQL_TIMEOUT} [seconds]"
echo "POSTGRESQL_WAIT: ${POSTGRESQL_WAIT} [seconds]"

echo "Generating configuration file from template..."
mkdir -p /etc/clair
/usr/local/bin/dockerize -template /config.template:/etc/clair/config.yaml
echo "*******************************"
echo "FINAL CONFIGURATION<<<<<<<<<<<<"
echo "*******************************"
cat /etc/clair/config.yaml
echo "*******************************"
echo ">>>>>>>>>>>>FINAL CONFIGURATION"
echo "*******************************"
if [[ ${POSTGRESQL_WAIT} -gt 0 ]] ; then
    echo "Sleeping for ${POSTGRESQL_WAIT} seconds..."
    sleep ${POSTGRESQL_WAIT}    
fi
if [[ ${POSTGRESQL_TIMEOUT} -gt 0 ]] ; then
    echo "Waiting for PostgreSQL server ${POSTGRESQL_HOSTNAME}:${POSTGRESQL_PORT} to come up..."
    TIMEOUT_PARAM="-wait tcp://${POSTGRESQL_HOSTNAME}:${POSTGRESQL_PORT} -timeout ${POSTGRESQL_TIMEOUT}s"
fi 
/usr/local/bin/dockerize ${TIMEOUT_PARAM} /clair
