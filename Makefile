
APP_NAME	= inception

COMPOSE_DIR	= -f srcs/docker-compose.yml
ENV_FILE	= --env-file srcs/.env

#COMPOSE_DIR	= -f bonus/bonus-compose.yml
#ENV_FILE	= --env-file bonus/.env
DOCKER		= docker-compose ${COMPOSE_DIR} ${ENV_FILE} -p ${APP_NAME}

RM			= rm -rf


all:		build start


build:		#wordpress nginx mariadb
		${DOCKER} build --no-cache

wordpress:
		${DOCKER} build wordpress
		${DOCKER} up -d wordpress

nginx:
		${DOCKER} build nginx
		${DOCKER} up -d nginx

mariadb:
		${DOCKER} build mariadb
		${DOCKER} up -d mariadb

redis:
		${DOCKER} build redis
		${DOCKER} up -d redis


start:
		${DOCKER} up -d

down:
		${DOCKER} down

clean:		
		${DOCKER} down --volumes
		${RM} ~/data/wp/*
		${RM} ~/data/db/*

re:		clean all

.PHONY:		all build wordpress nginx mariadb start down clean re