# CRUD API

[![Build Status](https://ci.timohermans.nl/api/badges/timohermans/betaaloverzicht-api/status.svg?ref=refs/heads/main)](https://ci.timohermans.nl/timohermans/betaaloverzicht-api)

## JWKS certificate

[Grab it here](https://<auth0 domain>.eu.auth0.com/.well-known/jwks.json)

After you grabbed it, put it in the certs folder with the name rsa.jwks.pub. When Docker start, it will mount it to the correct directory.

## JWT Claim key

There is no default way to map roles from Auth0 to PostgREST. Luckily, Auth0 provides a way to perform custom code before a jwt token is consumes. This is called (Auth0) Actions. I created a custom (fake) URL/namespace that has to be filled in the .env PGRST_ROLE_CLAIM_KEY key. 

## Docker caveats

Make sure the developer machine is NTP time synced.
For a Macbook that would be to set `pool.ntp.org` as time server.

Also, then make sure the docker machine is in sync with the host machine (in my case my Macbook). To do this, run `docker run --privileged --rm alpine date -s "$(date -u "+%Y-%m-%d %H:%M:%S")"`
