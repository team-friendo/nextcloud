# nextcloud

Running nextcloud via docker. To be ansiblized eventually.

1) Run bootstrap and setup an ssh alias in ~/.ssh/config for `friendo-cloud`

2) Install docker: `make docker`

3) Setup firewall: `make ufw`

4) Setup nextcloud `make nextcloud`

5) Go to cloud.solidarity.camp (or your favorite nextcloud url) and finish setup

6) Configure onlyoffice: `make onlyoffice`

## Notes

I (@ziggy) tried this to setup encryption but it failed due to permission errors.

a docker + apache + encfs + eclipis clusterfuck.

``` sh
sudo apt install encfs
sudo mkdir -p /srv/nextcloud /srv/nextcloud/data /srv/nextcloud/.encrypted
sudo encfs /srv/nextcloud/.encrypted /srv/nextcloud/data
# (enter password)

chown -R www-data:root /srv/nextcloud/data
```
