#!/bin/bash
set -x
echo "Starting hubot-slack"
PATH=/usr/bin:/bin:/usr/local/bin
source hubot.config
bin/hubot --adapter slack
