#!/usr/bin/env bash

cd /nextcloud

# source env vars, bail with error nif env vars undefined
source .env
set -eu

echo "--- checking if nextcloud instance available"

check-until-available(){
  count=$1
  if [ ${count} -gt 300 ];then
    echo  "--- instance not available after 5 minutes. exiting"
    exit 0
  else
    status=$(curl -I https://test.solidarity.camp | sed -n 1p | awk '{print $2}')
    if [ ${status} != "200" ] && [ ${status} != "302"];then
      echo  "--- instance not available. checking again in 5sec..."
      let new_count=$count+1
      sleep 5
      check-until-available $new_count
    else
      echo  "--- instance available! continuing."
    fi
  fi
}

check-until-available 0
