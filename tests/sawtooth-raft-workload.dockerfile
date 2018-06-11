FROM ubuntu:xenial

RUN apt-get update \
 && apt-get install -y -q --allow-downgrades \
    build-essential \
    curl \
    libssl-dev \
    gcc \
    git \
    libzmq3-dev \
    openssl \
    pkg-config \
    unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -OLsS https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip \
 && unzip protoc-3.5.1-linux-x86_64.zip -d protoc3 \
 && rm protoc-3.5.1-linux-x86_64.zip

RUN curl https://sh.rustup.rs -sSf > /usr/bin/rustup-init \
 && chmod +x /usr/bin/rustup-init \
 && rustup-init -y

ENV PATH=$PATH:/protoc3/bin:/project/sawtooth-core/bin:/root/.cargo/bin \
    CARGO_INCREMENTAL=0

RUN git clone https://github.com/hyperledger/sawtooth-core

WORKDIR /sawtooth-core/perf

RUN cd intkey_workload && cargo build
RUN cd smallbank_workload && cargo build
