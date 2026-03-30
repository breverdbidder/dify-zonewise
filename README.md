# ZoneWise.AI — Dify Community Fork

**House Brand:** Navy #1E3A5F | Orange #F59E0B | BG #020617

Fork of [langgenius/dify](https://github.com/langgenius/dify) (v1.13.3) customized for ZoneWise.AI / Everest Capital USA.

## Changes from upstream
- Logos replaced with ZoneWise.AI branding
- "Powered by Dify" → "Powered by ZoneWise.AI"  
- House brand colors applied
- Hetzner deployment script included

## Deploy to Hetzner
```bash
chmod +x deploy-hetzner.sh
./deploy-hetzner.sh
```

## Upstream sync
```bash
git remote add upstream https://github.com/langgenius/dify.git
git fetch upstream
git merge upstream/main
# Resolve brand conflicts in web/public/logo/ and i18n files
```

## Architecture
```
zonewise.ai (Next.js, Stripe, SEO) → calls Dify Service API
dify.zonewise.ai (this fork) → invisible backend
  ├── Knowledge Base: Brevard zoning ordinances
  ├── Custom Tool: BCPAO GIS API
  ├── Custom Tool: Supabase zoning queries  
  ├── Agent Workflow: address → lookup → format
  └── LLM: Smart Router (Gemini → DeepSeek → Sonnet)
```
