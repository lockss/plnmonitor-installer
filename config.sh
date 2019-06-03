# Configuration of plnmonitor

# start plnmonitor database
docker-compose up  -d plnmonitordb

until docker exec plnmonitor-installer_plnmonitordb_1  pg_isready -h localhost -U plnmonitor; do
  echo >&2 " Please wait for database to start... (this can take up to one minute)"
  sleep 10
done
echo "Database is now ready !"

# run configuration of the daemon
java -jar plnmonitor-daemon.jar config

docker-compose down