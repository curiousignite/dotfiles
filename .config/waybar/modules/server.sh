#!/bin/bash

#TODO: Add ports for spesific services for tooltip text

local_server="192.168.1.81"
remote_server="dietpi.tail0e6854.ts.net"
if nc -z $local_server 22 2>/dev/null; then
  echo "{\"text\":\"󰒋\", \"tooltip\":\"Local server is up and running at $local_server\"}"
else
  if nc -z $remote_server 22 2>/dev/null; then
    echo "{\"text\":\"󰒋\", \"tooltip\":\"Remote server is up and running at $remote_server\"}"
  else
    echo "{\"text\":\"󰒏\", \"tooltip\":\"Server is down!\"}"
  fi
fi
