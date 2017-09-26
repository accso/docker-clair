# docker-clair

A simple container that creating the Clair configuration file `/etc/clair/config.yaml` from
enviroment settings and waits for the PostgreSQL server to be up before Clair is started.

Both aspects (implemented using [dockerize](https://github.com/jwilder/dockerize)) come in handy 
when the container is used in a CI context (e.g. GitLab-CI) where
mounting directories and waiting for services are not (easily) supported.

The container requires the following variables to be passed as environment settings:
* `POSTGRESQL_HOSTNAME`: defaults to `postgres`
* `POSTGRESQL_USERNAME`: defaults to `postgres`
* `POSTGRESQL_PORT`: defaults to `5432`
* `POSTGRESQL_TIMEOUT`: defaults to `10` (time in seconds before dockerize gives up on PostgreSQL)
* `PGPASSWORD`: no default

Note that the setting `PGPASSWORD` is not specific to this container but is a general feature of 
the PostgreSQL binaries.
