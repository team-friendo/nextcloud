#!/bin/sh

sudo mkdir -p /etc/caddy
sudo mkdir -p /etc/caddy/.caddy

cat << EOF | sudo tee /etc/caddy/Caddyfile
cloud.solidarity.camp {
  tls team-friendo@riseup.net
  proxy / http://nextcloud:80 {
    transparent
  }

  log stdout
  errors stderr
}
EOF

sudo chown root:root /etc/caddy/Caddyfile
sudo chmod 644 /etc/caddy/Caddyfile
sudo chown -R root:root /etc/caddy

cat << EOF | sudo tee /srv/nextcloud/docker-compose.yml
version: '3'

volumes:
  nextcloud:

services:
  nextcloud:
    image: nextcloud:15
    volumes:
      - nextcloud:/var/www/html
    restart: always
    

  caddy:
    image: abiosoft/caddy:latest
    ports:
      - 80:80
      - 443:443
    environment:
      - ACME_AGREE=true
    volumes:
      - /etc/caddy/.caddy:/root/.caddy
      - /etc/caddy/Caddyfile:/etc/Caddyfile
    links:
      - nextcloud
EOF

sudo chown -R root:root /srv/nextcloud
sudo chmod 600 -R /srv/nextcloud

sudo sh -c 'cd /srv/nextcloud && docker-compose up -d'
