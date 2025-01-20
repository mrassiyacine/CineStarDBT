
echo "loading environment variables from .env file..."

set -a
source .env
set +a

echo "Starting ..."

docker-compose up -d postgres

until docker exec -it $POSTGRES_CONTAINER_NAME pg_isready -U $POSTGRES_USER > /dev/null 2>&1; do
  echo "PostgreSQL is not ready yet. Waiting..."
  sleep 2
done

echo "Restoring the DVD Rental database from 'dvdrental.tar'..."

docker exec -it $POSTGRES_CONTAINER_NAME pg_restore -U $POSTGRES_USER -d $POSTGRES_DB /docker-entrypoint-initdb.d/dvdrental.tar > /dev/null 2>&1;

echo "DVD Rental database setup complete."

echo "Starting the dbt service..."

docker-compose up -d dbt_service

echo "Running dbt..."

docker exec -it dbt_service dbt run;

docker exec -it dbt_service dbt test;

echo "Starting the Metabase service..."

docker-compose up -d metabase_service

echo "Go to http://localhost:3000 to access Metabase"