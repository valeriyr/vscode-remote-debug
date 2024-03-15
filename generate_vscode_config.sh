#!/bin/sh

# Debuggable application local path
export APPLICATION_LOCAL_PATH=""

# Debugger port
export DEBUGGER_PORT=1234

# Local repository root directory
export LOCAL_REPO_ROOT=""
# Docker repository mount root directory
export DOCKER_REPO_MOUNT_ROOT=""

if [ -z "$APPLICATION_LOCAL_PATH" ]; then
    echo "Debuggable application local path should be specified!"
    exit 1
fi
if [ -z "$DEBUGGER_PORT" ]; then
    echo "Debugger port should be specified!"
    exit 2
fi
if [ -z "$LOCAL_REPO_ROOT" ]; then
    echo "Local repository root directory should be specified!"
    exit 3
fi
if [ -z "$DOCKER_REPO_MOUNT_ROOT" ]; then
    echo "Docker repository mount root directory should be specified!"
    exit 4
fi

echo
echo "------------------------------------------------------------"
echo "Generating VSCode launch configuration:"
echo "------------------------------------------------------------"
echo "Application local path:     $APPLICATION_LOCAL_PATH"
echo "Debugger port:              $DEBUGGER_PORT"
echo "Local repository:           $LOCAL_REPO_ROOT"
echo "Docker repository:          $DOCKER_REPO_MOUNT_ROOT"
echo "------------------------------------------------------------"
echo

envsubst < ./launch.json > "$LOCAL_REPO_ROOT/.vscode/launch.json"
