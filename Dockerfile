FROM alpine:3.7

# Setting up crontab
#COPY crontab /tmp/crontab
#RUN cat /tmp/crontab > /etc/crontabs/root

#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

#RUN apt-get update
#RUN apt install -y cron curl wget jq
#RUN apt install -y procps python
#RUN apt-get clean
#VOLUME /etc/cron.d/

RUN apk update
RUN apk add curl wget jq procps python
RUN apk add htop

#CMD [ "/usr/sbin/cron","-f","-L /dev/stdout" ]
CMD [ "crond","-f","-l", "15", "-L", "/dev/stdout" ]
