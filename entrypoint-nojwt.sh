#!/bin/sh
set -e

echo "====================================================================="

echo "Wait for server..."
sleep 10

MAX_ATTEMPTS=5
attempt=0

echo "Starting Grafana..."
echo ""

DB_PATH="/var/lib/grafana/grafana.db"
TEMPLATE_DB="/etc/grafana-db/grafana.db.template"

# Check if the database exists in the volume
if [ ! -f "$DB_PATH" ]; then
    echo "No existing Grafana database found. Copying default..."
    cp "$TEMPLATE_DB" "$DB_PATH"
    echo "Copying default plugins..."
    cp -r /etc/grafana-plugins /var/lib/grafana/plugins/
else
    echo "Existing Grafana database found. Skipping copy."
fi

sed "s|\${JWT_TOKEN}|${JWT_TOKEN}|g" /etc/grafana/provisioning/datasources/jsonapi-datasource.template.yaml > /etc/grafana/provisioning/datasources/jsonapi-datasource.yaml

chmod 775 "$DB_PATH"

echo "====================================================================="
# Execute the original Grafana entrypoint
exec /run.sh
