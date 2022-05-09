# Build Stage
FROM --platform=linux/amd64 ubuntu:22.04 as builder
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install  -y cmake clang

ADD . /dagger
WORKDIR /dagger/build
RUN cmake ..
RUN make -j8

FROM --platform=linux/amd64 ubuntu:22.04

COPY --from=builder /dagger/build/bin/llvm-dec .
