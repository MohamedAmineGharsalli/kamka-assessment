# KAMKA Assessment — Todo App (CI/CD & Infrastructure)

Three-tier Todo application demonstrating containerization, CI/CD pipeline, and monitoring.

## Stack
- **Frontend**: Nginx serving static HTML/JS
- **Backend**: Node.js + Express REST API
- **Database**: PostgreSQL 16
- **Monitoring**: Uptime Kuma
- **CI/CD**: GitHub Actions → GHCR

## Prerequisites
- Docker & Docker Compose v2+
- Git

## Quick Start (local)

```bash
git clone https://github.com/MohamedAmineGharsalli/kamka-assessment.git
cd kamka-assessment
cp .env.example .env   # edit values if needed
docker compose up --build
```

- App: http://localhost
- API health: http://localhost:3000/health
- Monitoring: http://localhost:3001

## Environment Variables

Copy `.env.example` to `.env` and fill in your values:

| Variable | Description | Default |
|---|---|---|
| POSTGRES_USER | DB username | postgres |
| POSTGRES_PASSWORD | DB password | changeme |
| POSTGRES_DB | DB name | todos |
| API_PORT | Backend port | 3000 |

Never commit `.env` — it is gitignored.

## CI/CD Pipeline

On every push to `main`, GitHub Actions:
1. **Lint & Test** — installs deps, runs lint and tests
2. **Build & Push** — builds Docker images, pushes to GHCR
3. **Deploy** — deployment step (extensible to real server)

## Scripts

```bash
# Deploy
bash scripts/deploy.sh

# Backup database
bash scripts/backup-db.sh
```

## Dev vs Prod

| | Dev | Prod |
|---|---|---|
| Images | Built locally | Pre-built from GHCR |
| Ports | 3000 exposed | Only 80 exposed |
| Restart | No | unless-stopped |
| Compose file | docker-compose.yml | docker-compose.prod.yml |

## Architecture
Browser → Nginx (port 80) → Node.js API (port 3000) → PostgreSQL (port 5432)
↑
Uptime Kuma (port 3001)
## Known Limitations
- No HTTPS (would add Caddy or Traefik in production)
- Single instance, no horizontal scaling
- Deploy step is simulated (no real server provisioned)
- Secrets managed via .env file (would use Vault or cloud secrets manager in production)
