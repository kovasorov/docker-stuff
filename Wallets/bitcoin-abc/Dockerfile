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

# установка кошелька bitcoin abc
FROM ubuntu:latest AS instbitcoinabc

ENV BITCOIN_ABC_DATA=/bitcoin/.bitcoin
ENV BITCOIN_ABC_VERSION=0.18.5
ENV HOME /bitcoin
ENV PACKAGES="ca-certificates curl gnupg"

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} bitcoin \
      && useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

# качаем релиз bitcoin abc и ставим его
RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y --no-install-recommends ${PACKAGES} \
      && gpg --keyserver subset.pool.sks-keyservers.net --recv-key 3BB16D00D9A6D281591BDC76E4486356E7A81D2C \
      && curl -LO --compressed "https://download.bitcoinabc.org/${BITCOIN_ABC_VERSION}/linux/bitcoin-abc-${BITCOIN_ABC_VERSION}-x86_64-linux-gnu.tar.gz" \
      && curl -L --compressed "https://download.bitcoinabc.org/${BITCOIN_ABC_VERSION}/SHA256SUMS.jasonbcox.asc" | gpg --verify \
      && tar --strip=1 -xzf bitcoin-abc-${BITCOIN_ABC_VERSION}-x86_64-linux-gnu.tar.gz -C / \
# чистка
	    && apt-get remove -y ${PACKAGES} \
	    && apt-get autoremove -y \
	    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* bitcoin-abc-${BITCOIN_ABC_VERSION}-x86_64-linux-gnu.tar.gz SHA256SUMS.jasonbcox.asc

VOLUME ["/bitcoin"]

# копируем собранный su-exec и скрипт docker-entrypoint.sh
COPY --from=makesuexec /usr/sbin/su-exec /usr/sbin
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8332 8333 18332 18333 18444

#WORKDIR /bitcoin

CMD ["bitcoind"]