# magi-docker
This repository contains the instructions to setup a conterized version of the Magi (XMG) daemon. 
A docker image is provided on docker hub. So far, only x86_64 and arm64 architectures are supported. 

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
| vx.x.x.x | ✅ | Specific release (check [available releases](https://github.com/aaronmee/magi-docker/blob/main/README.md#available-releases)) |



## Setup (Linux)
1. Download the and enter the repository
  ```bash
  git clone https://github.com/aaronmee/magi-docker.git
  cd magi-docker
  ```
2. Download newest blockchain (optional, but recommended)
  * Go to https://chain.magicoin.de
  * Copy the link to the newest file
  ```bash
  megadl <link_to_blockchain.zip>
  ```
  * Unzip the folder
  ```bash
  unzip <blockchain.zip>
  ```
  * Move the blockchain to the `data` folder
  ```bash
  mv -r <blockchain> data/blockchain
  ```
3. Update the `data/magi.conf` file and copy your `wallet.dat` file into the `data` folder, if needed
4. Start the container using the image. You can either use docker compose or the [docker cli](https://github.com/aaronmee/magi-docker/blob/main/README.md#docker-cli). 
  ```bash
  docker compose up -d
  ```
  > Note: The content of docker-compose.yaml is listed below

## Windows
### Docker Desktop ([click here to install](https://docs.docker.com/desktop/install/windows-install/))
1. Create a folder to store your files
2. Create a `data` subfolder and a `magi.conf`file inside
3. Paste the content from https://github.com/aaronmee/magi-docker/blob/main/magi.conf to your magi.conf file and adjust the settings, if needed
4. Open `Docker Desktop`
5. Search for `magi-docker`using the search bar
   > Note: Make sure to select the image by `aaronme`, the other one serves a different purpose.
6. Hit `Run`


### docker-compose (recommended, [click here to install](https://docs.docker.com/compose/install/))
```yaml
---
services:
  magi:
    image: aaronme/magi-docker:v1.4.7.2
    container_name: magi-docker
    ports:
      - "8232:8232"
      - "8233:8233"
    volumes:
      - ./data:/magi/data
    restart: unless-stopped
```
### docker cli ([click here to install](https://docs.docker.com/engine/install/))
```bash
docker run -d \
  --name magi-docker \
  -p 8232:8232 \
  -p 8233:8233 \
  -v ./data:/magi/data \
  --restart unless-stopped \
  aaronme/magi-docker:v1.4.7.2
```

## Available releases
Supported at the moment is:
* v1.4.7.2 (latest)
