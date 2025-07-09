#!/bin/bash

set -e

function error_exit {
  echo "❌ Error: $1" >&2
  exit 1
}

echo "🔍 Checking Docker availability..."
if ! command -v docker &> /dev/null; then
  error_exit "Docker not found. Please ensure Docker is properly installed in the devcontainer."
fi

# Wait for Docker daemon to be ready
echo "⌛ Waiting for Docker daemon to be ready..."
timeout=30
count=0
while ! docker info > /dev/null 2>&1; do
  if [ $count -ge $timeout ]; then
    error_exit "Docker daemon failed to start within $timeout seconds"
  fi
  echo "   Docker daemon not ready yet, waiting... ($count/$timeout)"
  sleep 2
  ((count+=2))
done

echo "✅ Docker is ready!"

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
  error_exit "Neither docker-compose nor 'docker compose' command found"
fi

# Use docker compose if available, fallback to docker-compose
COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null 2>&1; then
  COMPOSE_CMD="docker-compose"
fi

if [ ! -d "./workflows" ]; then
  error_exit "Expected ./workflows directory does not exist. Please create it and add workflow JSON files."
fi

echo "🚀 Starting n8n via Docker Compose..."
$COMPOSE_CMD up -d || error_exit "Failed to start Docker Compose"

echo "⌛ Waiting for n8n to be ready..."
timeout=60
count=0
until curl -s http://localhost:5678/healthz > /dev/null 2>&1; do
  if [ $count -ge $timeout ]; then
    error_exit "n8n failed to start within $timeout seconds"
  fi
  echo "   n8n not ready yet, waiting... ($count/$timeout)"
  sleep 3
  ((count+=3))
done

echo "📥 Importing workflows..."
for file in ./workflows/*.json; do
  if [ -f "$file" ]; then
    echo "📄 Importing $(basename "$file")"
    # Get the container ID for n8n
    container_id=$(docker ps -qf "ancestor=n8nio/n8n")
    if [ -n "$container_id" ]; then
      docker exec "$container_id" n8n import:workflow --input "/workflows/$(basename "$file")" || echo "⚠️ Failed to import $(basename "$file")"
    else
      echo "⚠️ Could not find n8n container to import workflows"
    fi
  fi
done

echo ""
echo "✅ n8n setup complete!"
echo "🌐 n8n is now available at: http://localhost:5678"
echo "🔐 Login credentials:"
echo "   Username: admin"
echo "   Password: adminpassword"
echo ""
echo "💡 Tip: The port should be automatically forwarded in GitHub Codespace"
