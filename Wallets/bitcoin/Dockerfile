# сборка su-exec
FROM ubuntu:latest AS makesuexec

# необходимые зависимости для сборки
ENV PACKAGES="ca-certificates curl gcc libc6-dev make"
ENV SUEXEC="https://github.com/ncopa/su-exec/archive/v0.2.tar.gz"

# устанавливаем зависимости, скачиваем и собираем su-exec
RUN apt-get update && apt-get install -y --no-install-recommends ${PACKAGES} \
	&& curl ${SUEXEC} -Lo suexec.tar.gz  \
	&& tar -xzf suexec.tar.gz \
	&& cd su-exec-0.2 && make \
	&& cp su-exec /usr/sbin \
# чистка
	&& apt-get remove -y ${PACKAGES} \
	&& apt-get autoremove -y \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& rm -rf /su-exec-0.2  /suexec.tar.gz

# установка кошелька bitcoin
FROM ubuntu:latest AS instbitcoin

ENV BITCOIN_DATA=/bitcoin/.bitcoin
ENV BITCOIN_VERSION=0.17.0.1
ENV HOME /bitcoin
ENV PACKAGES="ca-certificates curl gnupg"

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} bitcoin \
	&& useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

# качаем релиз bitcoin и ставим его
RUN apt-get update && apt-get install -y --no-install-recommends ${PACKAGES} \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-key 01EA5486DE18A882D4C2684590C8019E36C2E964 \
    && curl -O https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
    && curl https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc | gpg --verify - \
    && tar --strip=1 -xzf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz -C / \
# чистка
	&& apt-get remove -y ${PACKAGES} \
	&& apt-get autoremove -y \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz /bin/bitcoin-qt

VOLUME ["/bitcoin"]

# копируем собранный su-exec и скрипт docker-entrypoint.sh
COPY --from=makesuexec /usr/sbin/su-exec /usr/sbin
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8332 8333 18332 18333 18444

#WORKDIR /bitcoin

CMD ["bitcoind"]