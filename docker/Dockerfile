FROM debian:stretch
LABEL maintainer="Demystify Developers <dev@demystify.com>"
LABEL description="Dockerised DemystifyCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
