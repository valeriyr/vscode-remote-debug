# Base image
FROM rust:1.75-bullseye

# Debugger port argument
ARG DEBUGGER_PORT

# Example of additional packages required by an application
RUN apt-get update && apt-get install -y cmake llvm-dev libclang-dev clang libpq-dev lldb

# Debug port exposing
EXPOSE ${DEBUGGER_PORT}
