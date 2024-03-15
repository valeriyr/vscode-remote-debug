#!/bin/sh

# Docker image name
IMAGE_NAME="app-debugger"

# Docker image platform
IMAGE_PLATFORM="linux/arm64"

# Debugger port
DEBUGGER_PORT=1234

# Local repository root directory
LOCAL_REPO_ROOT=""
# Docker repository mount root directory
DOCKER_REPO_MOUNT_ROOT=""

if [ -z "$IMAGE_NAME" ]; then
    echo "Docker image name should be specified!"
    exit 1
fi
if [ -z "$IMAGE_PLATFORM" ]; then
    echo "Docker image platform should be specified!"
    exit 2
fi
if [ -z "$DEBUGGER_PORT" ]; then
    echo "Debugger port should be specified!"
    exit 3
fi
if [ -z "$LOCAL_REPO_ROOT" ]; then
    echo "Local repository root directory should be specified!"
    exit 4
fi
if [ -z "$DOCKER_REPO_MOUNT_ROOT" ]; then
    echo "Docker repository mount root directory should be specified!"
    exit 5
fi

echo "------------------------------------------------------------"
echo "Building $IMAGE_NAME docker image:"
echo "------------------------------------------------------------"
echo "Platform:                  $IMAGE_PLATFORM"
echo "Debugger port:             $DEBUGGER_PORT"
echo "Local repository root:     $LOCAL_REPO_ROOT"
echo "Docker repository root:    $DOCKER_REPO_MOUNT_ROOT"
echo "------------------------------------------------------------"
echo

docker build \
-t "$IMAGE_NAME" \
--platform "$IMAGE_PLATFORM" \
--build-arg DEBUGGER_PORT="$DEBUGGER_PORT" \
.

echo
echo "------------------------------------------------------------"
echo "Running $IMAGE_NAME docker container:"
echo "------------------------------------------------------------"
echo

docker run \
--rm \
--platform "$IMAGE_PLATFORM" \
-p $DEBUGGER_PORT:$DEBUGGER_PORT \
-v "$LOCAL_REPO_ROOT":"$DOCKER_REPO_MOUNT_ROOT" \
-w "$DOCKER_REPO_MOUNT_ROOT" \
-it "$IMAGE_NAME" \
/bin/bash
