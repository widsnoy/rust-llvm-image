FROM debian:unstable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    build-essential \
    pkg-config \
    llvm-21-dev \
    clang-21 \
    libclang-21-dev \
    mingw-w64 \
    gcc-mingw-w64-x86-64 \
    && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=${CARGO_HOME}/bin:$PATH
ENV RUSTUP_TOOLCHAIN=stable

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable \
    && rustup component add clippy rustfmt \
    && rustup target add x86_64-pc-windows-gnu \
    && rustup target add x86_64-unknown-linux-gnu \
    && cargo install cargo-make \
    && chmod -R a+w ${RUSTUP_HOME} ${CARGO_HOME} \
    && rustc --version \
    && cargo --version \
    && cargo clippy --version \
    && cargo fmt --version

ENV LLVM_SYS_211_PREFIX=/usr
ENV LLVM_CONFIG_PATH=/usr/bin/llvm-config-21

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"

WORKDIR /app
