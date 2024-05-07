# magi-docker
This repository contains instructions to setup a conterized version of the Magi (XMG) daemon. 
A docker image is provided on docker hub, which is built from source. 


## Supported architectures
The docker image is built for multiple architectures at the same time.
Simply pulling `aaronme/magi-docker:latest` should retreive the correct image for your architecture. 
The currently supported architectures are:
| Architecture | Available | Note |
| :----: | :----: | ---- |
| x86-64 | ✅ | Not yet fully tested |
| arm64 | ✅ | Not yet fully tested |
| armv7 | ❌ | Work in progress |

## Version tags
This image provides various versions that are available via tags:
| Tag | Available | Description |
| :----: | :----: |--- |
| latest | ✅ | Latest stable release |
| vx.x.x.x | ✅ | Specific release ([available releases](https://github.com/aaronmee/magi-docker/blob/main/README.md#available-releases)) |


## Setup
To get started creating a container from this image you can either use docker-compose or the docker cli.

Make sure the `data` directory exists and contains a `magi.conf` file, containing at least an rpcuser and an rpcpassword. 

### docker-compose (recommended, [install](https://docs.docker.com/compose/install/))
```yaml
---
services:
  magi-docker:
    image: aaronme/magi-docker:latest
    container_name: magi-docker
    ports:
      - "8232:8232"
      - "8233:8233"
    volumes:
      - ./data:/magi/data
    restart: unless-stopped
```
Start the container with
```bash
docker compose up -d
```

### docker cli ([install](https://docs.docker.com/engine/install/))
```bash
docker run -d \
  --name magi-docker \
  -p 8232:8232 \
  -p 8233:8233 \
  -v ./data:/magi/data \
  --restart unless-stopped \
  aaronme/magi-docker:latest
```

## Post Setup (optional)

Always stop the container when editing files in the data directory.

### Blockchain
Download the newest blockchain (speeds up initial syncing)
* Go to https://chain.magicoin.de
* Copy the link for the newest file
* Install MEGA command line tools
```bash
sudo apt install megatools
```
* Download the blockchain
```bash
megadl <link_to_blockchain.zip>
```
* Unzip the folder
```bash
unzip <blockchain.zip>
```
* Move the blockchain to the magi `data` folder
```bash
mv <blockchain> data/blockchain
```

### Magi configuration
The magi configuration file is located at `data/magi.conf`

## Available releases
Supported at the moment is:
* v1.4.7.2 (latest)

## Support
This repository is managed and maintained by aaronmee.

If you  run into problems or need help, you can reach out to @aaronmee on our [community discord](https://discord.gg/JYJpXeXAH3).
