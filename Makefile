
APP_NAME		= inception


COMPOSE_DIR		= -f srcs/test-compose.yml
ENV_FILE		= --env-file srcs/.env
DOCK			= docker-compose ${COMPOSE_DIR} ${ENV_FILE} -p ${APP_NAME}

AR			= ar rcs
CP			= cp -f
RM			= rm -f

CFLAGS		= -Wall -Wextra -Werror

.c.o:
			${CC} ${CFLAGS} -c $< -o ${<:.c=.o}

all:		
		${DOCK} up -d

test:
		${DOCK_TEST} up -d
utest:
		${DOCK_TEST} down
rtest:
		${DOCK_TEST} up -d --build

logs:
		${DOCK_TEST} logs

flogs:
		${DOCK_TEST} logs -f

bonus:		${NAMEB_C} ${NAMEB_S}

clean:
			${DOCK} down

fclean:		clean
			${DOCK} down --volumes

re:			fclean all

.PHONY:		all bonus clean fclean re