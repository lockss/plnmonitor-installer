#!/bin/bash
# Set the URL of lockss props server (lockss.xml)
echo "Configuration of plnmonitor daemon"
echo "Name of your PLN: " 
read LOCKSS_NET_NAME
echo "LOCKSS props server URL (e.g. http://lockssadmin.ulb.ac.be/lockss.xml): " 
read LOCKSS_PROPS_URL

echo "INSERT INTO pln VALUES ('$LOCKSS_NET_NAME', '$LOCKSS_PROPS_URL', 1);" > ./add_pln.sql

docker build -t plnmondaemon -f DockerfileDaemon .
docker build -t plnmonwebapp -f DockerfileWebapp .





