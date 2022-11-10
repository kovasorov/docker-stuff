###
# 1. Скачиваем Converse.js
###
FROM busybox as downld

WORKDIR /tmp/punch

RUN wget -c https://github.com/conversejs/converse.js/archive/v5.0.5.tar.gz -O - | tar -xz --strip-components=1

###
# 2. Собираем Converse.js
###
#FROM node:10-alpine as buildnodejs
FROM node:10-buster as buildnodejs

WORKDIR /tmp/cmpl

COPY --from=downld /tmp/punch .

#RUN apk add --update make git g++ python && make dist
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y make git g++ && make dist
###
# 3. Скачиваем punjab
###
FROM alpine/git as downldpj

WORKDIR /tmp/punch

RUN git clone https://github.com/twonds/punjab.git

###
# 4. Собираем punjab, копируем Converse,js
###
#FROM python:3-alpine
FROM python:3.7-buster

WORKDIR /tmp/cmplpj

COPY --from=downldpj /tmp/punch/punjab/ .

#RUN apk --no-cache add build-base libressl-dev libffi-dev nginx python-dev \ 
#    && pip install -r requirements.txt \
#    && python setup.py install 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx \ 
    && pip install -r requirements.txt \
    && python setup.py install 

WORKDIR /usr/share/nginx/html

COPY --from=buildnodejs /tmp/cmpl .

#RUN mkdir -p /run/nginx && rm /etc/nginx/conf.d/*
RUN mkdir -p /run/nginx
COPY site.conf /etc/nginx/conf.d/

RUN mv index.html index_bak.html \
    && cp fullscreen.html index.html \
    && sed -i 's+https://conversejs.org/http-bind/+/http-bind/+g' index.html

WORKDIR /tmp

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT entrypoint.sh
