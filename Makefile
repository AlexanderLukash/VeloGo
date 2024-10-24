DC = docker compose
EXEC = docker exec -it
LOGS = docker logs
ENV_FILE = --env-file .env
APP_FILE = docker_compose/app.yaml
STORAGES_FILE = docker_compose/storages.yaml
APP_CONTAINER = main-app
DB_CONTAINER = velogo-db
MANAGE_PY = python manage.py

.PHONY: storages
storages:
	${DC} -f ${STORAGES_FILE} ${ENV_FILE} up -d

.PHONY: storages-down
storages-down:
	${DC} -f ${STORAGES_FILE} down

.PHONY: storages-logs
storages-logs:
	${LOGS} ${DB_CONTAINER} -f

.PHONY: all
all:
	${DC} -f ${APP_FILE} -f ${STORAGES_FILE} ${ENV_FILE} up -d

.PHONY: all-down
all-down:
	${DC} -f ${APP_FILE} -f ${STORAGES_FILE} down

.PHONY: app
app:
	${DC} -f ${APP_FILE} ${ENV_FILE} up -d

.PHONY: app-down
app-down:
	${DC} -f ${APP_FILE} down

.PHONY: app-logs
app-logs:
	${LOGS} ${APP_CONTAINER} -f

.PHONY: migrate
migrate:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} migrate

.PHONY: migrations
migrations:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} makemigrations

.PHONY: superuser
superuser:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} createsuperuser

.PHONY: collectstatic
collectstatic:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} collectstatic
