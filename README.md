# nextcloud

Running nextcloud via docker. To be ansiblized eventually.

1) Run bootstrap and setup an ssh alias in ~/.ssh/config for `friendo-cloud`

2) Install docker: `make install-docker`

3) Download docker images: `make download-docker-images`

4) Setup firewall: `make ufw`

5) Setup docker nextcloud `make setup-nextcloud`

6) Go to cloud.solidarity.camp and finish setup

7) Add cloud.solidarity.camp to trusted domain by editing some wacky file:

``` sh
sudo nano /var/lib/docker/volumes/nextcloud_nextcloud/_data/config/config.php
```

^^^ yup, we should figure out a better way


## Notes

I tried this to setup encryption but it failed due to permission errors.

a docker + apache + encfs + eclipis clusterfuck.

``` sh
sudo apt install encfs
sudo mkdir -p /srv/nextcloud /srv/nextcloud/data /srv/nextcloud/.encrypted
sudo encfs /srv/nextcloud/.encrypted /srv/nextcloud/data
# (enter password)

chown -R www-data:root /srv/nextcloud/data
```
