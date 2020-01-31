FROM ubuntu:latest

ENV ZCASH_VERSION="2.0.2"
ENV ZCASH_URL="https://z.cash/downloads/zcash-${ZCASH_VERSION}-linux64.tar.gz"
ENV ZCASH_SHA256="54171c6baf853d306525336d09dc1acab723573f64d1d82efa6b3a975a3354db"
ENV PACKAGES="apt-transport-https ca-certificates curl libgomp1"

ENV ZZCASH_USER="zcash"
ENV ZCASH_HOME="/root"
ENV PARAMS_DIR="${ZCASH_HOME}/.zcash-params"

RUN apt-get update \
        && apt-get -y upgrade \
        && apt-get -y --no-install-recommends install ${PACKAGES} \
        && curl -LO --compressed ${ZCASH_URL} \
        && echo "${ZCASH_SHA256} zcash-${ZCASH_VERSION}-linux64.tar.gz" | sha256sum -c - \
        && tar --strip=1 -xzf zcash-${ZCASH_VERSION}-linux64.tar.gz -C / \
        && apt-get autoremove -y \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /zcash-${ZCASH_VERSION} /zcash-${ZCASH_VERSION}-linux64.tar.gz

RUN mkdir -p "${ZCASH_HOME}/.zcash" "${PARAMS_DIR}"

WORKDIR ${ZCASH_HOME}

VOLUME ["${PARAMS_DIR}", "${ZCASH_HOME}/.zcash"]

EXPOSE 8232 18232

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["zcashd"]