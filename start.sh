#!/bin/bash

export GENERIC_TIMEZONE="Asia/Kolkata"
export N8N_PORT=5678

echo "🛠 Starting n8n on http://localhost:${N8N_PORT} ..."
n8n &

# Wait for n8n to fully boot
echo "⏳ Waiting for n8n to start..."
sleep 10

# Auto-load the workflow
echo "📦 Injecting workflow.json ..."
node load-workflow.js