# tiddlywiki-node
Tiddlywiki NodeJS container listening on port `8080`:
```
docker run -it --init \
    -p 8080:8080  \
    -e TIDDLYWIKI_USERNAME=mrzzy \
    -e TIDDLYWIKI_PASSWORD=changethis \
    -v /path/to/your/wiki:/wiki \
    ghcr.io/mrzzy/tiddlywiki-node:5.1.23
```

## Volume / Storage
Mount / Persist `\wiki` to storage in order persist wiki contents accross container restarts

## Configuration
Configuration of the container is done via environment variables:
| Environment Variable | Descripition |
| --- | --- |
| `TIDDLYWIKI_AUTH_HEADER` | If set, configures the http header that tiddly uses to obtain the requester's username. |
| `TIDDLYWIKI_READERS` | Comma separated list of usernames allowed to read from this wiki. |
| `TIDDLYWIKI_WRITERS` | Comma separated list of usernames allowed to read from this wiki. |
| `TIDDLYWIKI_USERNAME` & `TIDDLYWIKI_PASSWORD` | If set, configures tiddlywiki to use basic http authentication. |
| `TIDDLYWIKI_DEBUG` | Whether to configure tiddlywiki to output debugging logs |
