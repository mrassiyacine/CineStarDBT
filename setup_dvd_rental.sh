
echo "Setting up DVD Rental Database"
echo "loading environment variables from .env file..."

set -a
source .env
set +a

echo "Starting the docker container ..."

docker-compose up -d postgres

until docker exec -it $POSTGRES_CONTAINER_NAME pg_isready -U $POSTGRES_USER > /dev/null 2>&1; do
  echo "PostgreSQL is not ready yet. Waiting..."
  sleep 2
done

echo "Restoring the DVD Rental database from 'dvdrental.tar'..."

docker exec -it $POSTGRES_CONTAINER_NAME pg_restore -U $POSTGRES_USER -d $POSTGRES_DB /docker-entrypoint-initdb.d/dvdrental.tar > /dev/null 2>&1;

echo "DVD Rental database setup complete."