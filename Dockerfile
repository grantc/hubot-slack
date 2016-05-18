FROM node:5.11.1

MAINTAINER Grant Croker <grant@solidgear.es>

RUN apt-get -q update
RUN apt-get -qy install redis-server

RUN npm install -g yo generator-hubot coffee-script

RUN cd $(npm root -g)/npm \
 && npm install fs-extra \
 && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js

RUN adduser --disabled-password --gecos "" hubot; \
  echo "hubot ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/hubot
USER hubot
WORKDIR /home/hubot

RUN yo hubot --owner="Grant <grant@solidgear.es>" \
  --name="Marvin" \
  --description="I have a million ideas. They all point to certain death." \
  --adapter="slack"

COPY package.json /home/hubot/package.json
COPY external-scripts.json /home/hubot/external-scripts.json
COPY hubot.config /home/hubot/hubot.config
COPY start.sh /home/hubot/start.sh

RUN npm install

RUN rm -rf /home/hubot/node_modules/hubot-scripts

ENV JENKINS_USER bob
ENV JENKINS_PASSWORD super_secret
ENV JENKINS_URL http://localhost/jenkins
ENV SLACK_TOKEN xoxb...
ENV NAGIOS_URL http://localhost/nagios
ENV NAGIOS_ROOM general 

CMD /home/hubot/start.sh
