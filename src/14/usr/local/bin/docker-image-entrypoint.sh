#!/usr/bin/env bash

#set -e

OWNER=$(stat -c '%u' /data)
GROUP=$(stat -c '%g' /data)

if [[ "$OWNER" != "0" ]]; then
    usermod -u $OWNER node 2> /dev/null
    groupmod -g $GROUP node 2> /dev/null
fi

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- node "$@"
# check if the first argument passed in is the application name
elif [ "$1" = "node" ]; then
  set -- "$@"
fi

gosu node "$@"