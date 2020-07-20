# strongSwan

## Usage

```bash
docker run -it --rm \
  --cap-add=NET_ADMIN \
  --net=host \
  --volume $PWD/config:/config/ \
  --name strongswan \
  wanderadock/strongswan:${TAG}
```

## Build and push

```bash
export TAG=0.1.X
docker build -t wanderadock/strongswan:${TAG} .
docker push wanderadock/strongswan:${TAG}
```

## Docker repository

The tool is released as a docker image, check the [repository](https://hub.docker.com/r/wanderadock/strongswan).
