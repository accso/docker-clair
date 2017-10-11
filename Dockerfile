FROM  quay.io/coreos/clair:v2.0.1
MAINTAINER marcus.rickert@accso.de

ENV POSTGRESQL_HOSTNAME=postgres
ENV POSTGRESQL_USERNAME=postgres
ENV POSTGRESQL_PORT=5432
ENV POSTGRESQL_TIMEOUT=10
ENV POSTGRESQL_WAIT=0
ENV CLAIR_UPDATE_INTERVAL=24

RUN mkdir -p /tmp/scan && \
    apk update && \
    apk add openssl

# Installiere dockerize
ENV DOCKERIZE_VERSION=v0.5.0
ENV DOCKERIZE_DOWNLOAD_URL=https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN wget -qO- $DOCKERIZE_DOWNLOAD_URL | tar xvz -C /usr/local/bin

# Installiere ein modifiziertes Init-Skript, das dockerize aufruft
COPY assets/config.template /config.template
COPY assets/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
