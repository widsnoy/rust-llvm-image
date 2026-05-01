FROM archlinux:base-devel

RUN pacman -Syu --noconfirm --needed \
    ca-certificates \
    curl \
    git \
    pkgconf \
    llvm21 \
    clang21 \
    mingw-w64-gcc \
    && pacman -Scc --noconfirm

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/lib/llvm21/bin:${CARGO_HOME}/bin:$PATH
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

ENV LLVM_SYS_211_PREFIX=/usr/lib/llvm21
ENV LLVM_CONFIG_PATH=/usr/lib/llvm21/bin/llvm-config
ENV LIBCLANG_PATH=/usr/lib

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"

WORKDIR /app
