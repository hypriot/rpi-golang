
# Pull base image
FROM resin/rpi-raspbian:wheezy
FROM hypriot/rpi-golang:1.4.2
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    gcc \
    libc6-dev \
    make \
    git \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Compile Go from source
ENV GOROOT_BOOTSTRAP /goroot
ENV GOLANG_VERSION 1.7
ADD ./etc/services /etc/services
RUN \
    mkdir -p /goroot1.7 && \
    git clone https://go.googlesource.com/go /goroot1.7 && \
    cd /goroot1.7 && \
    git checkout go$GOLANG_VERSION && \
    cd /goroot1.7/src && \
    GOARM=6 ./all.bash

# Set environment variables
ENV GOROOT /goroot1.7
ENV GOPATH /gopath1.7
ENV GOARM 6
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Define working directory
WORKDIR /gopath1.7

# Define default command
CMD ["bash"]
