SHELL := /bin/sh

COMPOSE := docker compose
SERVICES := gateway client auth incident dispatch postgres-auth postgres-incident postgres-dispatch redis

.PHONY: help build up down restart ps logs logs-% stop reset prune

help:
	@echo "Targets:"
	@echo "  make build        Build all images"
	@echo "  make up           Start full stack (detached)"
	@echo "  make down         Stop stack"
	@echo "  make restart      Restart stack"
	@echo "  make ps           Show container status"
	@echo "  make logs         Follow logs for app services"
	@echo "  make logs-auth    Follow logs for one service (logs-gateway, logs-client, etc.)"
	@echo "  make stop         Stop containers without removing"
	@echo "  make reset        Stop and remove containers + volumes"
	@echo "  make prune        Remove dangling images"

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up --build -d

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down

restart: down up

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f gateway client auth incident dispatch

logs-%:
	$(COMPOSE) logs -f $*

reset:
	$(COMPOSE) down -v --remove-orphans

prune:
	docker image prune -f
