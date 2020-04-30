# strongSwan

## Usage

```bash
docker run -it --rm \
  --cap-add=NET_ADMIN \
  --net=host \
  --volume $PWD/config:/config/ \
  --name strongswan \
  wanderadock/strongswan:0.1.4
```

## Docker repository

The tool is released as a docker image, check the [repository](https://hub.docker.com/r/wanderadock/strongswan).
