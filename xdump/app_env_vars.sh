#!/bin/bash

DOCKER_IMAGE_OS=ubuntu
CONTAINER_USER=root

LOG_MESSAGE="Checkpoint now"
LOG_LOCATION="/opt/appcr/xdump_logs/xdump.log"

APP_DOCKER_IMAGE="xdump:latest"
APP_CR_DOCKER_IMAGE="xdump-cr:latest"

# Add application specific env variables here
APP_CONTAINER="XdumpTest"

DUMP_OPTIONS="-Xdump:java:events=catch,filter=java/io/UnsupportedEncodingException,file=/opt/appcr/xdump_logs/dumps/javacore_unsupported.%H%M%S.txt"
HOST_VOLUME="$HOME/xdump_logs"
CONTAINER_VOLUME="/opt/appcr/xdump_logs"


