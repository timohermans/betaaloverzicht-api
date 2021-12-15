# CRUD API

## JWKS certificate

[Grab it here](https://<auth0 domain>.eu.auth0.com/.well-known/jwks.json)

## Docker caveats

Make sure the developer machine is NTP time synced.
For a Macbook that would be to set `pool.ntp.org` as time server.

Also, then make sure the docker machine is in sync with the host machine (in my case my Macbook). To do this, run `docker run --privileged --rm alpine date -s "$(date -u "+%Y-%m-%d %H:%M:%S")"`