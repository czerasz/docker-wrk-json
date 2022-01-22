FROM debian:jessie
MAINTAINER Michał Czeraszkiewicz <czerasz.hosting@gmail.com>

# Set the reset cache variable
ENV REFRESHED_AT 2015-06-15

ENV DEBIAN_FRONTEND noninteractive

# Update packages list
RUN apt-get update -y

# Install useful packages
# RUN apt-get install -y strace procps tree vim git curl wget gnuplot

# Install required software
RUN apt-get install -y git make build-essential libssl-dev zip

# Install wrk - benchmarking software
# Resource: https://github.com/wg/wrk/wiki/Installing-Wrk-on-Linux
WORKDIR /tmp

RUN git clone https://github.com/wg/wrk.git &&\
    cd wrk &&\
    make &&\
    mv wrk /usr/local/bin

# Install Luarocks dependencies
RUN apt-get install -y curl \
                       make \
                       unzip \
                       lua5.1 \
                       liblua5.1-dev

# Install Luarocks - a lua package manager
RUN curl http://keplerproject.github.io/luarocks/releases/luarocks-2.2.2.tar.gz -O &&\
    tar -xzvf luarocks-2.2.2.tar.gz &&\
    cd luarocks-2.2.2 &&\
    ./configure &&\
    make build &&\
    make install

# Install the cjson package
RUN luarocks install lua-cjson

WORKDIR /

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Raise the limits to successfully run benchmarks
RUN ulimit -c -m -s -t unlimited

ENV DEBIAN_FRONTEND=newt
