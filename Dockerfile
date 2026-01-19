FROM alpine:edge

RUN apk add --no-cache \
    git \
    build-base \
    llvm21-dev \
    clang21-dev \
    rust \
    cargo \
    rust-clippy \
    rustfmt \
    cargo-make

ENV LLVM_SYS_211_PREFIX=/usr
ENV LLVM_CONFIG_PATH=/usr/bin/llvm-config-21

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"

WORKDIR /app
