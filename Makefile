SSH := ssh friendo-cloud 'bash -s'

default:
	@echo 'nextcloud setup!'

docker:
	$(SSH) < ./scripts/docker.sh

ufw:
	$(SSH) < ./scripts/ufw.sh

nextcloud:
	$(SSH) < ./scripts/nextcloud.sh

onlyoffice:
	$(SSH) < ./scripts/onlyoffice.sh

.PHONY: default ufw docker nextcloud onlyoffice
