#!/bin/bash
set -x
echo "Starting hubot-slack"
PATH=/usr/bin:/bin:/usr/local/bin
source hubot.config
if [ "x${HUBOT_SLACK_EXIT_ON_DISCONNECT}" == "xtrue" ]; then
  while /bin/true
  do
    bin/hubot --adapter slack
    sleep 5
  done
else
  bin/hubot --adapter slack
fi
