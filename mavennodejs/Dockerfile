FROM maven:3.6.1-jdk-8-slim

ENV NODEJS_VER="10.15.3"

# install dependencies for webpack build, nodejs
RUN apt-get update && apt-get install -y python \
                                         make \
                                         g++ \
                                         gcc \
                                         gnupg && \
    curl -L --progress-bar --compressed "https://nodejs.org/dist/v${NODEJS_VER}/node-v${NODEJS_VER}-linux-x64.tar.gz" | tar --strip=1 -xz -C /

COPY settings.xml /root/.m2/settings.xml

CMD ["mvn"]
