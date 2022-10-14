# Docker builds

Build SMSWithoutBorders microservices with docker

## Requirements

- docker
- docker-compose
- GNU make

## Configuration

This repository only contains the docker configuration files needed for building the containers. The source code for various services are pulled in using submodules.

## Setup

After cloning start the build script and follow along. Make sure you have all credentials ready for all sections as you will be required to fill them in.

The build script will build all docker images

```bash
make
```

**Note** When configuring the backend,

- Set mysql host to `127.0.0.1` so that it can communicate with the host system database over tcp. `localhost` will not work
- Set custom platform paths to point to `./custom_platforms/<platform name>` folder which will be created in the backend container at build time.

```bash
[PLATFORMS]
GMAIL=./custom_platforms/gmail/gmail_app.py
SLACK=./custom_platforms/slack/slack_app.py
TWITTER=./custom_platforms/twitter/twitter_app.py
TELEGRAM=./custom_platforms/telegram/telegram_app.py
```

- Be sure to add `127.0.0.1` to the allowed origins array since the frontend will be running on port `80`

```bash
ORIGINS=["https://127.0.0.1"]
```

**Note** When configuring gateway server

- Replace all `localhost` origins with `127.0.0.1`

## Running containers

After as successful build, 1 image is created

- smswithoutborders:[tag]

Start container with docker-compose as daemons

```bash
docker-compose up -d
```

View container logs

```bash
docker-compose logs -f smswithoutborders
```

Stop containers

```bash
docker-compose down
```
