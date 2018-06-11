FROM ubuntu:xenial

RUN apt-get update && apt-get install -y -q \
    python3 \
    python3-nose2
