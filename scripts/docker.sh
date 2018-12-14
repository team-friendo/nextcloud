#!/bin/sh

sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common


curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -


echo 'please verify the key fingerprint ....'
sudo apt-key fingerprint 0EBFCD88

echo 'should equal: '
echo  '9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88'
echo ''
sleep 10

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt-get update && sudo apt-get install -y docker-ce
