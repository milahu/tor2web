#!/usr/bin/env bash

tor2web=./bin/tor2web
#tor2web=tor2web

datadir=/run/user/$UID/tor2web-data

if ! [ -e tor2web.conf ]; then
  cp -v tor2web.conf.example tor2web.conf
fi

mkdir -p $datadir
mkdir -p $datadir/certs
mkdir -p $datadir/logs
mkdir -p $datadir/run

touch $datadir/certs/tor2web-key.pem
touch $datadir/certs/tor2web-cert.pem

if ! [ -e $datadir/templates/ ]; then
  cp -r data/templates/ $datadir/
fi

if [ -e $datadir/run/rpc.socket ]; then
  rm $datadir/run/rpc.socket
fi

exec $tor2web -c tor2web.conf --rundir $datadir/run --pidfile $datadir/tor2web.pid --nodaemon
