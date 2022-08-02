#!/bin/bash

CD=$(dirname $(readlink -f $0))


if [ "$1" == "-s" ] ; then
	docker exec -ti pipevfx-crond /bin/sh

elif [ "$1" == "-l" ] ; then
	docker logs --tail 50 -f pipevfx-crond

else
	docker build . -t pipevfx-crond
	docker rm -f pipevfx-crond
	docker run --name pipevfx-crond -d \
		--restart always \
		--privileged \
		-v /frankbarton:/frankbarton \
		-v $CD/scripts:/scripts \
		-v $CD/crontab:/etc/crontabs/root \
	pipevfx-crond:latest
fi
