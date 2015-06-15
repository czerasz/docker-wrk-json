# Docker WRK JSON Environment

This repository contains **Dockerfile** of [Debian](https://www.debian.org/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/czerasz/monit-base/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

Analysing the `Dockerfile` one can get an overview how to install wrk from source.

This project delivers a [wrk](https://github.com/wg/wrk) environment with JSON support - in simple words it enables you to use JSON inside your Lua scripts.

## Base Docker Image

- debian:jessie


## Requirements:

- [Docker](http://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Usage

Download [automated build](https://registry.hub.docker.com/u/czerasz/wrk-json/) from public [Docker Hub Registry](https://registry.hub.docker.com/):

    docker pull czerasz/wrk-json

Alternatively, you can build an image from Dockerfile:

    docker build -t="czerasz/wrk-json" github.com/czerasz/docker-wrk-json

## Example

Clone this repository and enter it's direcotry.

Start all containers:

    docker-compose run wrk bash

Watch the `application` container logs in another terminal with:

    docker logs -f --tail=0 $(docker-compose ps | grep '_application_1' | awk '{print $1}')

Benchmark the application from inside the wrk docker container:

    wrk -c1 -t1 -d1s -s /scripts/multi-request-json.lua http://app:3000

As soon as you start the benchmark the application container logs should output request details:

    [2015-06-15 17:10:12] Request 28132

    GET/1.1 /path-1 on :::3000

    Headers:
     - host: app:3000
     - x-custom-header-2: test 2
     - content-length: 12
     - x-custom-header-1: test 1

    No cookies

    Body:
    some content
