SHELL=/usr/bin/env bash

dc:
	@cp docker-compose.yml.dist docker-compose.yml

build:
	@docker-compose build

hash_password:
	@docker exec -it wride symfony console security:hash-password

install_composer:
	@docker-compose up -d
	@docker exec -it wride composer install

install_npm:
	@docker exec -it wride npm install

start:
	@docker exec -it wride symfony serve -d
	@docker exec -it wride npm run watch

tests:
	@docker exec -it wride php ./vendor/bin/phpunit --do-not-cache-result

clear_cache:
	@docker exec -it wride symfony console cache:clear

phpstan:
	@docker exec -it wride vendor/bin/phpstan analyse src tests
