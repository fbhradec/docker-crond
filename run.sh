#!/bin/bash

STUDIO=frankbarton

CD=$(dirname $(readlink -f $0))


if [ "$1" == "-s" ] ; then
	docker exec -ti pipevfx-crond /bin/bash

elif [ "$1" == "-l" ] ; then
	docker logs --tail 50 -f pipevfx-crond

else
	docker build . -t pipevfx-crond
	docker rm -f pipevfx-crond
	mkdir -p $CD/data
	rm -rf $CD/.crontab
	cat $CD/crontab | sed "s/__STUDIO__/$STUDIO/g" > $CD/.crontab
	docker run --name pipevfx-crond -d \
		--restart always \
		--privileged \
		-v $(readlink -f /$STUDIO/):/$STUDIO \
		-v /etc/passwd:/etc/passwd \
		-v /etc/group:/etc/group \
		-v /dev/shm:/dev/shm \
		-v $CD/data:/data \
		-v $CD/logs:/logs \
		-v $CD/.crontab:/etc/crontabs/root \
		-v $CD/.crontab:/var/spool/cron/crontabs/root \
		-v /var/run/docker.sock:/var/run/docker.sock \
	pipevfx-crond:latest
fi
