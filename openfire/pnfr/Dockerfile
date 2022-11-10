FROM ubuntu:xenial

ENV OPENFIRE_VERSION=4.4.4 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire \
    PACKAGES="curl sudo openjdk-8-jre"

WORKDIR /tmp

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ${PACKAGES} \
    && curl -LO "http://download.igniterealtime.org/openfire/openfire_${OPENFIRE_VERSION}_all.deb" \
    && dpkg -i openfire_${OPENFIRE_VERSION}_all.deb \
    && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
    && rm openfire_${OPENFIRE_VERSION}_all.deb \
    && rm -rf /var/lib/apt/lists/*

# Restore Openfire pre-config
#COPY openfire_conf.tar.gz .
#COPY portal-authprovider-1.0.0.jar /usr/share/openfire/lib/
#RUN tar -xzf openfire_conf.tar.gz --strip-components=1 -C /var/lib/openfire

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
