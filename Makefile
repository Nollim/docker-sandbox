export PROJECT_ROOT ?= $(shell pwd)
export CI_PROJECT_NAME ?= drupal-wework

SUPPORTED_COMMANDS := docker-compose-dev-up drush cache-clear composer-require drupal-bin
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

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
	docker container commit docker_php_1 nollim/php
	docker push nollim/php
	docker container commit docker_httpd_1 nollim/httpd
	docker push nollim/httpd
	docker container commit docker_elasticsearch_1 nollim/elasticsearch
	docker push nollim/elasticsearch
	docker container commit docker_mysql_1 nollim/mysql
	docker push nollim/mysql

drush:
	@docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml run --rm drush $(COMMAND_ARGS)

composer:
	@docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml run --rm php composer $(COMMAND_ARGS)

drupal-bin:
	@docker-compose -f ${PROJECT_ROOT}/config/docker/docker-compose-dev.yml run --rm php ./vendor/bin/$(COMMAND_ARGS)