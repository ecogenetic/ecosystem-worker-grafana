#!/bin/sh
set -e

echo "====================================================================="

echo "Wait for server..."
sleep 10

MAX_ATTEMPTS=5
attempt=0
TOKEN=""

while [ -z "$TOKEN" ] && [ "$attempt" -lt "$MAX_ATTEMPTS" ]; do
  attempt=$((attempt + 1))
  echo "Attempt $attempt: Fetching JWT token..."
  TOKEN=$(curl -s -X POST "$GF_AUTH_JWT_URL" \
    -H "Content-Type: application/json" \
    -d "{\"email\":\"$GF_AUTH_USERNAME\", \"password\":\"$GF_AUTH_PASSWORD\"}" \
    | sed -n 's/.*"access_token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
    | tr -d '\n')
  if [ -z "$TOKEN" ]; then
    echo "Token is empty, retrying in 30 seconds..."
    sleep 30
  fi
done
echo "Auth URL: $GF_AUTH_JWT_URL"
echo "Auth Username: $GF_AUTH_USERNAME"

echo "Starting Grafana..."
echo ""

if [ -n "$TOKEN" ]; then
    export JWT_TOKEN="$TOKEN"
    echo "export JWT_TOKEN=$TOKEN" >> /etc/environment
    echo "JWT token retrieved successfully."
else
    echo "Failed to retrieve JWT token."
fi

DB_PATH="/var/lib/grafana/grafana.db"
TEMPLATE_DB="/etc/grafana-db/grafana.db.template"

# Check if the database exists in the volume
if [ ! -f "$DB_PATH" ]; then
    echo "No existing Grafana database found. Copying default..."
    cp "$TEMPLATE_DB" "$DB_PATH"
else
    echo "Existing Grafana database found. Skipping copy."
fi

sed "s|\${JWT_TOKEN}|${JWT_TOKEN}|g" /etc/grafana/provisioning/datasources/jsonapi-datasource.template.yaml > /etc/grafana/provisioning/datasources/jsonapi-datasource.yaml

chmod 775 "$DB_PATH"
# In case a MAC created some files that will make the plugins fail.
find /var/lib/grafana -type f -name ".DS_Store" -exec rm -f {} +

echo "====================================================================="
# Execute the original Grafana entrypoint
exec /run.sh
