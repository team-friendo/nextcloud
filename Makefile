SSH := ssh friendo-cloud 'bash -s'

default:
	@echo 'nextcloud setup!'

install-docker:
	$(SSH) < ./scripts/docker.sh

ufw:
	$(SSH) < ./scripts/ufw.sh

download-docker-images:
	echo 'printf "nextcloud:15-apache\nabiosoft/caddy:latest\n" | xargs -I IMG sudo docker pull IMG' | $(SSH)

setup-nextcloud:
	$(SSH) < ./scripts/nextcloud.sh


.PHONY: default ufw download-docker-images setup-nextcloud
