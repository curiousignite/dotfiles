#!/bin/bash

#TODO: Add ports for spesific services for tooltip text

server="192.168.1.81"
server_remote="dietpi.tail0e6854.ts.net"
if nc -z $server 22 2>/dev/null; then
  echo "{\"text\":\"󰒋\", \"tooltip\":\"Local server is up and running at $server\"}"
else
  if nc -z $server_remote 22 2>/dev/null; then
    echo "{\"text\":\"󰒋\", \"tooltip\":\"Remote server is up and running at $server_remote\"}"
  else
    echo "{\"text\":\"󰒏\", \"tooltip\":\"Server is down!\"}"
  fi
fi
