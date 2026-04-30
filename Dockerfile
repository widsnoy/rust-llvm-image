FROM alpine:edge

RUN apk add --no-cache \
    git \
    build-base \
    llvm21-dev \
    clang21-dev \
    rustup \
    mingw-w64-binutils \
    mingw-w64-gcc \
    cargo-make

ENV PATH=/root/.cargo/bin:$PATH

RUN rustup-init -y --default-toolchain stable \
    && rustup component add clippy rustfmt \
    && rustup target add x86_64-pc-windows-gnu \
    && rustc --version \
    && cargo --version \
    && cargo clippy --version \
    && cargo fmt --version

ENV LLVM_SYS_211_PREFIX=/usr
ENV LLVM_CONFIG_PATH=/usr/bin/llvm-config-21

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"

WORKDIR /app
