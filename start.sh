#start all plnmonitor services

docker-compose up -d plnmonitordb
docker-compose up -d plnmonwebapp
docker-compose up plnmondaemon