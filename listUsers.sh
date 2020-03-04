#!/bin/bash

set -e

cut -d: -f1 /etc/passwd | grep user | sort
