#!/bin/bash

source ./common_env_vars.sh
source ./xtrace/app_env_vars.sh
source ./util.sh


if [ -z "${DOCKER_IMAGE_OS}" ]; then
	DOCKER_IMAGE_OS=ubuntu
fi
        
echo "Building application docker image ... "
cmd="docker build -q -t "${APP_DOCKER_IMAGE}" -f ./xtrace/Dockerfile.app ."
echo "CMD: ${cmd}"
${cmd} &>/dev/null
echo "Done"

check_image_exists "${APP_DOCKER_IMAGE}"
if [ $? -eq 1 ]; then
	echo "ERROR: Building application image failed"
	exit 1
fi


