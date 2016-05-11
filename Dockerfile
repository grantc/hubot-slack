FROM node:5.11.1

MAINTAINER Grant Croker <grant@solidgear.es>

RUN apt-get -q update
RUN apt-get -qy install redis-server

RUN npm install -g yo generator-hubot coffee-script

RUN adduser --disabled-password --gecos "" hubot; \
  echo "hubot ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/hubot
USER hubot
WORKDIR /home/hubot

COPY package.json /home/hubot/package.json
COPY external-scripts.json /home/hubot/external-scripts.json
COPY hubot.config /home/hubot/hubot.config
ADD start.sh /home/hubot/start.sh

RUN npm install

ENTRYPOINT ['/home/hubot/start.sh']
