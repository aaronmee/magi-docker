# Debian Buster as build image
FROM debian:bullseye as build

# Set working directory
WORKDIR /magi

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl build-essential libssl-dev libgmp-dev libminiupnpc-dev zlib1g-dev ca-certificates \ 
    libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-chrono-dev

# Compile the binary
RUN git clone https://github.com/aaronmee/magi.git \ 
    && cd magi/src/leveldb \
    && make clean \
    && make libleveldb.a libmemenv.a \
    && cd .. \
    && ../contrib/bdb/install_db4.8.sh \
    && make -j $(nproc) -f makefile.unix xCPUARCH=$(uname -m) STATIC=all CXXFLAGS="-s -static" \ 
    && cp magid /magi


# Alpine as container image
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
