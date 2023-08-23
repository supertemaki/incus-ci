# build stage
FROM golang:1.21.0-bookworm as build-stage

#RUN git clone --depth 1 https://github.com/lxc/distrobuilder.git --branch distrobuilder-2.1; \
#    cd distrobuilder; \
#    make

RUN git clone https://github.com/lxc/distrobuilder.git; \
    cd distrobuilder; \
    git ckeckout f77300b; \
    make


# final stage
FROM debian:12.1-slim as final-stage

RUN DEBIAN_FRONTEND=noninteractive apt update -qq; \
    apt install -y \
    rsync \
    xz-utils

COPY --from=build-stage /go/bin/distrobuilder /usr/local/bin

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
