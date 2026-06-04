#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-./backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/todos_${TIMESTAMP}.sql"

log() { echo "[$(date +%H:%M:%S)] $*"; }
die() { echo "ERROR: $*" >&2; exit 1; }

command -v docker &>/dev/null || die "Docker non trouve"

mkdir -p "$BACKUP_DIR"

log "Backup de la base de donnees..."
docker compose exec -T db pg_dump \
  -U "${POSTGRES_USER:-postgres}" \
  "${POSTGRES_DB:-todos}" > "$BACKUP_FILE"

log "Backup sauvegarde: $BACKUP_FILE"
log "Taille: $(du -h "$BACKUP_FILE" | cut -f1)"
