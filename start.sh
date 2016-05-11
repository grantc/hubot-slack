set -x
echo "Starting hubot-slack"
. hubot.config
bin/hubot --adapter slack
