SSH := ssh friendo-cloud 'bash -s'

default:
	@echo 'nextcloud setup!'


install-docker:
	$(SSH) < ./scripts/docker.sh


.PHONY: default install-docker
