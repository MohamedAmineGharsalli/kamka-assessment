#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.yml}"
ENV_FILE="${ENV_FILE:-.env}"

log() { echo "[$(date +%H:%M:%S)] $*"; }
die() { echo "ERROR: $*" >&2; exit 1; }

command -v docker &>/dev/null || die "Docker non trouve. Installe Docker d'abord."
[[ -f "$ENV_FILE" ]] || die "Fichier $ENV_FILE introuvable. Copie .env.example vers .env"

log "Pulling latest images..."
docker compose -f "$COMPOSE_FILE" pull --ignore-buildable

log "Starting services..."
docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d --build

log "Waiting for healthchecks..."
sleep 5

log "Services status:"
docker compose -f "$COMPOSE_FILE" ps

log "Deploy termine avec succes ✓"
