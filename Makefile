export PROJECT_ROOT ?= $(shell pwd)
export CI_PROJECT_NAME ?= drupal-wework

docker-compose-dev-up:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml up -d

docker-compose-dev-down:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml down -v

docker-compose-dev-config:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml config

docker-compose-prod-up:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod.yml up -d

docker-compose-prod-down:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod.yml down -v
