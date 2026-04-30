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

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=${CARGO_HOME}/bin:$PATH
ENV RUSTUP_TOOLCHAIN=stable

RUN rustup-init -y --default-toolchain stable \
    && rustup component add clippy rustfmt \
    && rustup target add x86_64-pc-windows-gnu \
    && rustup target add x86_64-unknown-linux-gnu \
    && chmod -R a+w ${RUSTUP_HOME} ${CARGO_HOME} \
    && rustc --version \
    && cargo --version \
    && cargo clippy --version \
    && cargo fmt --version

ENV LLVM_SYS_211_PREFIX=/usr
ENV LLVM_CONFIG_PATH=/usr/bin/llvm-config-21

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"

WORKDIR /app
