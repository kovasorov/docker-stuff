FROM ubuntu:latest

ENV NETCOREREPO_FILE="packages-microsoft-prod.deb"
ENV NETCOREREPO_URL="https://packages.microsoft.com/config/ubuntu/18.04/${NETCOREREPO_FILE}"
ENV NETCORESDK="dotnet-sdk-2.2"
ENV NEOCLI_VERSION="v2.9.2"
ENV NEOCLI_URL="https://github.com/neo-project/neo-cli/releases/download/${NEOCLI_VERSION}/neo-cli-linux-x64.zip"
ENV NEOCLI_SHA256="F7D3E2C0140BA6DDD8FF42EB01A542E011FF815D21D0F5382322AFD9AD6D4765"
ENV PACKAGES="apt-transport-https ca-certificates curl software-properties-common unzip"
ENV NEOCLI_PACK="expect libleveldb-dev libsqlite3-dev libunwind8-dev sqlite3"

RUN apt-get update \
        && apt-get -y upgrade \
        && apt-get -y --no-install-recommends install ${PACKAGES} ${NEOCLI_PACK} \
        && curl -LO --compressed ${NETCOREREPO_URL} \
        && dpkg -i ${NETCOREREPO_FILE} \
        && add-apt-repository universe \
        && apt-get update \
        && apt-get -y install ${NETCORESDK} \
        && curl -LO --compressed ${NEOCLI_URL} \
        && echo "${NEOCLI_SHA256} neo-cli-linux-x64.zip" | sha256sum -c - \
        && unzip neo-cli-linux-x64.zip -d /opt \
# чистка
        && apt-get remove -y ${PACKAGES} \
	&& apt-get autoremove -y \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /packages-microsoft-prod.deb /neo-cli-linux-x64.zip

COPY docker-entrypoint.sh /entrypoint.sh
COPY exec_neo.exp /exec_neo.exp
RUN chmod +x /entrypoint.sh
RUN chmod +x /exec_neo.exp

EXPOSE 10331 20331

WORKDIR /opt/neo-cli
RUN mkdir myneodata
VOLUME ["/opt/neo-cli/myneodata"]

ENTRYPOINT ["/entrypoint.sh"]