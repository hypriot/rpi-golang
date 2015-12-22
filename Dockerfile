# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>
MAINTAINER ANdreas Eiermann <andreas@hypriot.com>

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
ENV GOROOT /goroot
ENV GOPATH /go

COPY content/ $GOROOT
# Set environment variables

ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Define working directory
WORKDIR /go

ENV GOLANG_VERSION 1.5.2
ENV GOARM 6

# Define default command
CMD ["bash"]
