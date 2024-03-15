# vscode-remote-debug

`vscode-remote-debug` contains an example of how a Rust application running in a docker container can be debugged remotely from the host.

The main idea is that we have a locally cloned repository which is mounted to a running container.
The repository will be built inside the container and run using `lldb-server`.
And when the application is run, we will connect to it using `Visual Studio Code`.

## Initial setup

Need to be installed on the host:
1. [Rust](https://www.rust-lang.org/tools/install).
2. [Visual Studio Code](https://code.visualstudio.com/download) with the following extensions:
    - [rust-analizer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer).
    - [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb).
3. [Docker](https://www.docker.com/products/docker-desktop/).

## Build and run a `Docker` container

[build_and_run.sh](./build_and_run.sh) can be used to build and run a Docker container.

The script has several parameters that need to be configured before running:
1. `IMAGE_NAME` - Docker image name.
2. `IMAGE_PLATFORM` - Docker image platform.
3. `DEBUGGER_PORT` - Debugger port.
4. `LOCAL_REPO_ROOT` - Local repository root directory.
5. `DOCKER_REPO_MOUNT_ROOT` - Docker repository mount root directory.

As a result of script execution, the current terminal session will be connected to the run container with the repository mount directory as the working one.

## Running `lldb-server`

Now we can build an application using the `cargo` command:

```sh
cargo build -p application
```

And run a server instance, for example:

```sh
lldb-server gdbserver *:1234 ./target/debug/deps/application-f1d96820e5245ca2
```

As a result, a server instance will be run and waiting for a connection.

## `Visual Studio Code` setup

Since the server is run, we can open the `$LOCAL_REPO_ROOT` folder in `Visual Studio Code` and attach the debugger to the remotely run application.

To do this we need to create a configuration first.
[launch.json](./launch.json) is a launch configuration template that needs to be filled with the correct data and placed in the `$LOCAL_REPO_ROOT/.vscode` folder.

 We can use the [generate_vscode_config.sh](./generate_vscode_config.sh) script or do it manually.

The script has several parameters that need to be configured before running:
1. `APPLICATION_LOCAL_PATH` - Debuggable application local path.
2. `DEBUGGER_PORT` - Debugger port.
3. `LOCAL_REPO_ROOT` - Local repository root directory.
4. `DOCKER_REPO_MOUNT_ROOT` - Docker repository mount root directory.

## Attach to the `lldb-server` instace

Since `Visual Studio Code` is configured we can attach the run server just by clicking the `Start Debugging` button with the `Remote LLDB` configuration on the `Run and Debug` tab.
