# сборка su-exec
FROM ubuntu:latest AS makesuexec

# необходимые зависимости для сборки
ENV PACKAGES="ca-certificates curl gcc libc6-dev make"
ENV SUEXEC="https://github.com/ncopa/su-exec/archive/v0.2.tar.gz"

# устанавливаем зависимости, скачиваем и собираем su-exec
RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y --no-install-recommends ${PACKAGES} \
      && curl -L --compressed ${SUEXEC} | tar -xz \
          && cd su-exec-0.2 \
      && make \
          && cp su-exec /usr/sbin \
# чистка
          && apt-get remove -y ${PACKAGES} \
          && apt-get autoremove -y \
          && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /su-exec-0.2 /suexec.tar.gz

# установка кошелька litecoin
FROM ubuntu:latest  AS instlitecoin

ENV LITECOIN_VERSION="0.16.3"
ENV LITECOIN_DATA="/home/litecoin/.litecoin"
ENV LITECOIN_RELEASE="https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux"
ENV PACKAGES="ca-certificates curl gnupg"
ENV RELEASE_KEY="FE3348877809386C"

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} litecoin \
      && useradd -u ${USER_ID} -g litecoin -s /bin/bash -m litecoin

# качаем релиз litecoin и ставим его
RUN apt-get update \
      && apt-get upgrade -y \
            && apt-get install -y --no-install-recommends ${PACKAGES} \
      && gpg --keyserver subset.pool.sks-keyservers.net --recv-key ${RELEASE_KEY} \
      && curl -LO --compressed "${LITECOIN_RELEASE}/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz" \
      && curl -L --compressed "${LITECOIN_RELEASE}/litecoin-${LITECOIN_VERSION}-linux-signatures.asc" | gpg --verify \
      && tar --strip=1 -xzf litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz -C / \
# чистка
      && apt-get remove -y ${PACKAGES} \
      && apt-get autoremove -y \
      && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz /bin/litecoin-qt

VOLUME ["/home/litecoin/.litecoin"]

# копируем собранный su-exec и скрипт docker-entrypoint.sh
COPY --from=makesuexec /usr/sbin/su-exec /usr/sbin
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9332 9333 19332 19335

CMD ["litecoind"]