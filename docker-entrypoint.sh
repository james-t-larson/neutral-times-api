#!/bin/bash
set -e

if [[ -f /app/config/certs/server.key && -f /app/config/certs/server.crt ]]; then
  echo "SSL files found."
else
  echo "SSL files missing!"
fi

until pg_isready -h db -U postgres; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

bundle exec rails db:create db:schema:load db:migrate

exec "$@"

