#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "no password supplied"
	exit 1
fi


if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo "not running as root"
	exit 1
fi

pass=$1

users=$(cut -d: -f1 /etc/passwd | grep user | sort)

for user_to_modify in $users
do
	if pgrep -u $user_to_modify; then 
		echo "killing $user_to_modify processes"
		kill -9 $(pgrep -u $user_to_modify); 
	fi
	echo "cleaning $user_to_modify home directory"
	rm -rf /home/$user_to_modify/*
	echo "changing $user_to_modify password"
	echo $user_to_modify:$pass | chpasswd
done
