#!/usr/bin/env bash

cd /nextcloud

# source env vars, bail w/ error if env var undefined
source .env
set -eu

echo "--- creating nextcloud admin user and database"

docker exec -u www-data nextcloud-app php occ --no-warnings \
       maintenance:install \
       --database="mysql" \
       --database-name="nextcloud" \
       --database-user="nextcloud" \
       --database-host="db" \
       --database-pass="$MYSQL_PASSWORD" \
       --data-dir="/var/www/html/data" \
       --admin-user="$NEXTCLOUD_ADMIN_USER" \
       --admin-pass="$NEXTCLOUD_ADMIN_PASSWORD"

echo "--- sleeping..."
sleep 15
echo "--- awake!"

echo "--- setting trusted domains"

append_trusted_host(){
  # store arg
  host=$1

  # store trusted domains in temp file
  docker exec -u www-data nextcloud-app php occ --no-warnings \
         config:system:get trusted_domains \
         >> trusted_domain.tmp

  # if we don't see hostname as trusted domain, add it
  if ! grep -q $host trusted_domain.tmp; then
    idx=$(cat trusted_domain.tmp | wc -l);
    docker exec -u www-data nextcloud-app php occ --no-warnings \
           config:system:set trusted_domains $idx \
           --value=${host}
  fi

  # delete tmp file
  rm trusted_domain.tmp
}

append_trusted_host ${NEXTCLOUD_HOSTNAME}
append_trusted_host nextcloud-web

echo "--- configuring onlyoffice"

docker exec -u www-data nextcloud-app php occ --no-warnings \
       app:install onlyoffice

docker exec -u www-data nextcloud-app php occ --no-warnings \
       config:system:set onlyoffice DocumentServerUrl --value="/ds-vpath/"

docker exec -u www-data nextcloud-app php occ --no-warnings \
       config:system:set onlyoffice DocumentServerInternalUrl \
       --value="http://onlyoffice-document-server/"

docker exec -u www-data nextcloud-app php occ --no-warnings \
       config:system:set onlyoffice StorageUrl \
       --value="http://nextcloud-web/"
