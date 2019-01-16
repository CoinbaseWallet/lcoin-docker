Lcoin on Docker
=====

Start up a lcoin node quickly using Docker.
Pulls latest lcoin version from github and starts full node.

By default, persists data in user home directory at `~/.lcoin`.

How To Use
----

Copy sample configurations to `secrets/` directory:
>Important: Be sure to keep API secrets safe.
```
$ mkdir -p secrets
$ cp lcoin.example.conf secrets/lcoin.conf
$ cp wallet.example.conf secrets/wallet.conf
```

Create `lcoin` network:
```
$ docker network create lcoin
```

Create `nginx-proxy` network:
```
$ docker network create nginx-proxy
```

Quick run, node only:
```
$ docker-compose up -d lcoin
```

Update to latest lcoin version:
```
$ docker-compose build --pull lcoin
```

HTTPS
----
Includes optional nginx wrapper for https. Add domain certs to `secrets/certs/`.

Update docker-compose `VIRUAL_HOST` domain setting.

See https://github.com/jwilder/nginx-proxy for more options.

# Wallet HTTP
Note that Wallet and Node API servers are on separate ports.
With the default `docker-compose.yml` configuration, Wallet API is accessible via `lcoin.yourdomain.org:8334/wallet`, while node endpoints are accessed through default HTTP/HTTPS ports.

Provided is a simple example of an nginx proxy to allow wallet API to be accessible
on a separate domain, in order to make it unnecessary to specify wallet port.

See `docker-compose.wallet.yml`. (Not required to actually use wallet API)

# Building

By default, docker-compose will use image pulled from `petejkim/lcoin:latest`,
but you can build one yourself.

Latest is hard coded into Makefile and will need updates overtime,
but you can manually pass VERSION variable to override current version.

## Examples
Build v1.0.2:
  - `make` - Same as build
  - `make build` - Currently hard coded latest.
  - `make latest` - this will tag image as latest.
  - `VERSION=v1.0.2 make build`
