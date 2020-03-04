#!/bin/bash

set -e

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo "not running as root"
	exit 1
fi

users=$(cut -d: -f1 /etc/passwd | grep user)

for user_to_delete in $users
do
	if pgrep -u $user_to_delete; then 
		echo "killing $user_to_delete processes"
		kill -9 $(pgrep -u $user_to_delete); 
	fi
	echo "deleting $user_to_delete"
	deluser --remove-all-files $user_to_delete
done

