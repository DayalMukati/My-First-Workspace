#!/bin/bash

set -e

function error_exit {
  echo "❌ Error: $1" >&2
  exit 1
}

function log_info {
  echo "ℹ️ $1"
}

function log_success {
  echo "✅ $1"
}

function log_warning {
  echo "⚠️ $1"
}

# Check if this is a restart (containers might already be running)
log_info "Checking if Docker containers are running..."

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

log_success "Docker is ready!"

# Use docker compose if available, fallback to docker-compose
COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null 2>&1; then
  COMPOSE_CMD="docker-compose"
fi

# Check if containers are already running
if docker ps --format "table {{.Names}}" | grep -q "n8n-self-hosted-n8n-1"; then
  log_info "n8n containers are already running. Checking health..."
  
  # Check if n8n is responding
  if curl -s http://localhost:5678/healthz > /dev/null 2>&1; then
    log_success "n8n is healthy and running!"
    echo "🌐 n8n is available at: http://localhost:5678"
    echo "🔐 Login credentials:"
    echo "   Username: admin"
    echo "   Password: adminpassword"
    exit 0
  else
    log_warning "n8n containers are running but not responding. Restarting..."
    $COMPOSE_CMD down
  fi
fi

log_info "Starting n8n containers..."
$COMPOSE_CMD up -d || error_exit "Failed to start Docker Compose"

log_info "Waiting for n8n to be ready..."
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

log_success "n8n is ready!"
echo "🌐 n8n is available at: http://localhost:5678"
echo "🔐 Login credentials:"
echo "   Username: admin"
echo "   Password: adminpassword"
echo ""
echo "💡 Tip: The port should be automatically forwarded in GitHub Codespace" 