# Debian Buster as build image
FROM debian:bullseye as build

# Set working directory
WORKDIR /magi

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential libssl-dev libgmp-dev libminiupnpc-dev libdb-dev libdb5.3++-dev zlib1g-dev \ 
    libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-chrono-dev

# Compile the wallet (for some reason, there's an error with leveldb, so two files are generated manually)
RUN GIT_SSL_NO_VERIFY=true git clone https://github.com/aaronmee/magi.git \ 
    && cd magi/src/leveldb \
    && make clean \
    && make libleveldb.a libmemenv.a \
    && cd .. \
    && make -j $(nproc) -f makefile.unix xCPUARCH=$(uname -m) STATIC=all CXXFLAGS="-s -static -static-libgcc -static-libstdc++" \ 
    && cp magid /magi


# ALpine as container image
FROM alpine:latest as container

# Set working directory
WORKDIR /magi

# Copy binary from build
COPY --from=build /magi/magid .

# Set environment variables
ENV DATA_DIR /magi/data
ENV CONF /magi/data/magi.conf

# Expose ports
EXPOSE 8232 8233

# Define the volume
VOLUME /magi/data

# Define the entrypoint for the container
ENTRYPOINT ./magid -conf=$CONF -datadir=$DATA_DIR
