#FROM alpine:3.7
FROM debian:10

# Setting up crontab
#COPY crontab /tmp/crontab
#RUN cat /tmp/crontab > /etc/crontabs/root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt install -y cron curl wget jq 
RUN apt install -y procps python
RUN apt install -y binutils

# chrome need this to run and return the version with --version
RUN apt install -y \
	libglib2.0-0 \
	libnss3 \
	libatk1.0-0 \
	libatk-bridge2.0-0 \
	libcups2 libdrm2 \
	libxcomposite1 \
	libxkbcommon0 \
	libpango-1.0-0 \
	libcairo2 \
	libasound2 \
	libxdamage1 \
	libxrandr2 \
	libgbm1 

RUN apt install -y sudo 
RUN apt install -y rsync
RUN apt install -y libxxf86vm1
RUN apt-get update
# we need nodejs for scrapping using puppeteer
RUN apt install -y nodejs npm 
# blender 3.5 needs this now
RUN apt install -y libsm6
RUN apt install -y unzip
RUN apt-get clean
CMD [ "bash", "-c", "chmod 600 /var/spool/cron/crontabs/root ; cron -f -L 8" ]

#RUN apk update
#RUN apk add curl wget jq procps python
#RUN apk add htop
#RUN apk add bash
#RUN apk add binutils
#RUN apk add xz
#CMD [ "crond","-f","-l", "15", "-L", "/dev/stdout" ]
