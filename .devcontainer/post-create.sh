#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILES=(-f docker-compose.yml -f .devcontainer/docker-compose.codespaces.yml)

echo "Starting Nautobot stack (this may take a few minutes on first run)..."
docker compose "${COMPOSE_FILES[@]}" up -d

echo "Waiting for Nautobot health check..."
for _ in $(seq 1 60); do
  if docker compose "${COMPOSE_FILES[@]}" ps nautobot 2>/dev/null | grep -q "(healthy)"; then
    break
  fi
  sleep 5
done

echo
echo "Nautobot is starting. Open the forwarded port 8081 from the Ports tab."
echo "Default login: admin / admin"
echo
echo "Useful commands:"
echo "  docker compose -f docker-compose.yml -f .devcontainer/docker-compose.codespaces.yml logs -f"
echo "  docker compose -f docker-compose.yml -f .devcontainer/docker-compose.codespaces.yml down"
