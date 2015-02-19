
# Pull base image
FROM resin/rpi-raspbian
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
ENV GOLANG_VERSION 1.3.3
ADD ./etc/services /etc/services
RUN \
    mkdir -p /goroot && \
    git clone https://go.googlesource.com/go /goroot && \
    cd /goroot && \
    git checkout go$GOLANG_VERSION && \
    cd /goroot/src && \
    GOARM=6 ./all.bash 

# Set environment variables
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV GOARM 6
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Define working directory
WORKDIR /gopath

# Define default command
CMD ["bash"]
