#!/bin/bash

DOCKER_IMAGE_OS=ubuntu
CONTAINER_USER=root

LOG_MESSAGE="Checkpoint now"
LOG_LOCATION="/opt/appcr/xtrace_logs/xtrace.log"

APP_DOCKER_IMAGE="xtrace:latest"
APP_CR_DOCKER_IMAGE="xtrace-cr:latest"

# Add application specific env variables here
APP_CONTAINER="XtraceTest"

TRACE_OPTIONS="-Xtrace:methods={XtraceTest.displayCounter},print=mt,output=/opt/appcr/xtrace_logs/trace-%t.trc"
HOST_VOLUME="$HOME/xtrace_logs"
CONTAINER_VOLUME="/opt/appcr/xtrace_logs"


