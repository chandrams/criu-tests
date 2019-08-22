#!/bin/bash

source ./app_env_vars.sh

echo "${CONTAINER_VOLUME}"
echo "${LOG_LOCATION}"
java -cp /root XtraceTest ${CONTAINER_VOLUME} > ${LOG_LOCATION} 2>&1 &


