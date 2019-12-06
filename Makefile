export PROJECT_ROOT ?= $(shell pwd)
export CI_PROJECT_NAME ?= drupal-wework

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

docker-compose-dev-up:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml up -d --remove-orphans
	sensible-browser http://drupal.wework

docker-compose-dev-down:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml down -v

docker-compose-dev-config:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml config

docker-compose-prod-up:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod.yml up -d

docker-compose-prod-down:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod.yml down -v

docker-compose-prod-build-up:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod-build.yml up -d

docker-compose-prod-build-down:
	docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-prod-build.yml down -v

docker-commit:
	@make -s docker-compose-dev-down
	@make -s docker-compose-prod-down
	@make -s docker-compose-prod-build-down
	@make -s docker-compose-prod-build-up
	docker container commit docker_php_1 nollim/drupal
	docker push nollim/drupal

drush:
	@docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml run --rm drush $(call args)