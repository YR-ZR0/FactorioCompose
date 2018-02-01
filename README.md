# FactorioCompose

A ready to run docker compose repo with sane defaults for deployment

based on [dtandersen/docker_factorio_server](https://github.com/dtandersen/docker_factorio_server) and uses the following files from that repository:

- Dockerfile
- docker-entrypoint.sh

With the following changes:

- Mem limits to secure the container.
- Makes use of the .env docker compose file to specify factorio server version for tagging the image.
- Mounts the factorio volume into the same folder of execution for portability.
- Doesn't publicise the RCON port by default.
- Removed the need for a SHA1 variable for automated deployment.
- Added a HEALTHCHECK clause in the Dockerfile for health monitoring.

## How to deploy

```
docker-compose build
docker-compose up -d
```

## Configuration

- Move 27015:27015/tcp to the ports array for a public RCON adjust.
- mem_limt to a higher for larger maps.
- For rebuilding to the latest version edit the VERSION variables in both the compose file and the .env file.
- The Docked folder will contain the server files for drag and drop management after modifying just docker compose up again to recreate the server with the latest version.
