#!/usr/bin/env bash
export FIND_IP=$( hostname -I | awk 'BEGIN{FS=" "} {print " " $2 " " ARGV[1]}')
echo $FIND_IP
