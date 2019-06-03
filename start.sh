#start all plnmonitor services

docker-compose up -d plnmonitordb
docker-compose up -d plnmonwebapp
docker-compose up plnmondaemon

echo "plnmonitor is now available at : http://127.0.0.1:8084/plnmonitor-webapp/"
