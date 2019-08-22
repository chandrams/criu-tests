#!/bin/bash

source ../common_env_vars.sh
source ../util.sh

source ./app_env_vars.sh


test_case=$1
app_image=$2
app_container=$3

if [ -z "${app_image}" ]; then
	app_image="${APP_DOCKER_IMAGE}"
fi

if [ -z "${app_container}" ]; then
	app_container="${APP_CONTAINER}"
fi

./cleanup.sh "${app_container}"

cmd="docker run -e IBM_JAVA_OPTIONS=\"${TRACE_OPTIONS}\" -v ${HOST_VOLUME}:${CONTAINER_VOLUME} --name="${app_container}" "${DOCKER_CAPABILITIES}" "${DOCKER_SECURITY_OPTS}" -d  "${app_image}" " 

echo "CMD: ${cmd}"

app_id=`${cmd}`

if [ $? -ne 0 ]; then
	echo "ERROR: Failed to start app container"
	exit 1
fi

echo "INFO: App container id ${app_id}"
echo "INFO: App container started - Done"
