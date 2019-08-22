#!/bin/bash

app=$@

source ./${app}/app_env_vars.sh

source ./common_env_vars.sh

app_container="app-container-for-cr"

docker stop $app_container
docker rm $app_container


cmd="docker run -v ${HOST_VOLUME}:${CONTAINER_VOLUME} --name="${app_container}" "${DOCKER_CAPABILITIES}" "${DOCKER_SECURITY_OPTS}" -d  "${APP_CR_DOCKER_IMAGE}" "

echo
echo "Restoring from the checkpointed image..."
echo "CMD: ${cmd}"

app_id=`${cmd}`

if [ $? -ne 0 ]; then
        echo "ERROR: Failed to start app container"
        exit 1
fi

echo "INFO: App container id ${app_id}"
echo "INFO: App container started - Done"


echo "Stopping and removing the app contianer..."
docker stop $app_container
docker rm $app_container

File="${HOST_VOLUME}/${app}.log"
echo "Checking log file = $File for errors or failures...";
if grep -qi "Failed" "$File"; then
	echo "$app Test failed - check $File for failed details"
	exit 1
fi

if grep -qi "Error" "$File"; then
	echo "$app Test failed - check $File for error details"
	exit 1
fi

echo "$app Test Passed!"
rm -r $HOST_VOLUME/dumps $HOST_VOLUME/checkpoint
