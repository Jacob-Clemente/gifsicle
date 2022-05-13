# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf

## Add source code to the build stage.
ADD . /gifsicle
WORKDIR /gifsicle

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN autoreconf -i
RUN ./configure --disable-gifview --disable-gifdiff
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /gifsicle/src/gifsicle /
