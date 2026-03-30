#!/bin/bash
# ═══════════════════════════════════════════════════════════
# ZONEWISE.AI — Dify Community Fork Deployment
# Target: Hetzner 87.99.129.125
# Brand: Navy #1E3A5F | Orange #F59E0B | BG #020617
# ═══════════════════════════════════════════════════════════

set -euo pipefail

DEPLOY_DIR="/opt/dify-zonewise"
REPO="https://github.com/breverdbidder/dify-zonewise.git"

echo "🏗️ Deploying ZoneWise.AI (Dify fork) to Hetzner..."

# 1. Clone or pull
if [ -d "$DEPLOY_DIR" ]; then
    echo "→ Updating existing installation..."
    cd "$DEPLOY_DIR"
    git pull origin main
else
    echo "→ Fresh clone..."
    git clone --depth 1 "$REPO" "$DEPLOY_DIR"
    cd "$DEPLOY_DIR"
fi

# 2. Configure environment
cd docker
if [ ! -f .env ]; then
    cp .env.example .env
    echo "→ Created .env from template"
fi

# 3. Set ZoneWise-specific env vars
# These override defaults for our deployment
cat >> .env << 'ENVEOF'

# ═══ ZONEWISE OVERRIDES ═══
CONSOLE_API_URL=https://dify.zonewise.ai/console/api
CONSOLE_WEB_URL=https://dify.zonewise.ai
SERVICE_API_URL=https://dify.zonewise.ai/api
APP_WEB_URL=https://dify.zonewise.ai
VECTOR_STORE=pgvector
COMPOSE_PROFILES=pgvector,postgresql
SECRET_KEY=$(openssl rand -hex 32)
INIT_PASSWORD=zonewise2026
ENVEOF

echo "→ Environment configured"

# 4. Start services
echo "→ Starting Docker Compose..."
docker compose up -d

echo ""
echo "✅ ZoneWise.AI (Dify) deployed!"
echo "   Admin: http://localhost/install"
echo "   Password: zonewise2026"
echo ""
echo "Next steps:"
echo "  1. Set up Nginx reverse proxy for dify.zonewise.ai"
echo "  2. Add SSL via Cloudflare proxy"
echo "  3. Login and create first ZoneWise agent"
