#!/bin/bash

set -e

if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "no counter supplied"
	exit 1
fi

if [ -z "$2" ]; then
	echo "no password supplied"
	exit 1
fi

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo "not running as root"
	exit 1
fi

counter=$1
pass=$2

for i in $(seq "$counter");
do
	echo "creating user$i"
	user="user$i"
	adduser $user --disabled-password --gecos ""
	echo $user:$pass | chpasswd
done
