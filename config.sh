# Configuration of plnmonitor

# start plnmonitor database
docker-compose up  -d plnmonitordb

until docker exec plnmonitor-installer_plnmonitordb_1  pg_isready -h localhost -U plnmonitor; do
  echo >&2 " Waiting for database to start -- not available yet"
  sleep 10
done
echo >&2 "Database is up ! "

# run configuration of the daemon
java -jar plnmonitor-daemon.jar config

docker-compose down