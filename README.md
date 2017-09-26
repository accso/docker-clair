# docker-clair

A simple container that created the Clair configuration file `/etc/clair/config.yaml` from
enviroment settings and waits for the PostgreSQL server to be up before Clair is started.

Both aspects come in handy when the container is used in a CI context (e.g. GitLab-CI) where
mounting directories and waiting for services are not (easily) supported.
