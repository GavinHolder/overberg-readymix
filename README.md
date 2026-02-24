# Overberg Readymix

> Custom-built Django web platform for Overberg Readymix Concrete — engineered from the ground up, no WordPress, no templates.

[![Python](https://img.shields.io/badge/Python-3.13-3776AB?logo=python)](https://python.org)
[![Django](https://img.shields.io/badge/Django-6.0-092E20?logo=django)](https://djangoproject.com)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?logo=bootstrap)](https://getbootstrap.com)
[![Anime.js](https://img.shields.io/badge/Anime.js-4.3.6-FF6B6B)](https://animejs.com)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker)](https://docker.com)

---

## Project Phases

### Phase 1 — Standalone Landing Page · R5,000

Rapid deployment of a professional online presence while the full platform is engineered. Temporary standalone site — no CMS, replaced entirely by Phase 2 on completion.

**Includes:**
- One-page endless-scroll layout
- Company overview, services summary, high-quality imagery
- Basic contact form with bot/spam protection
- Mobile-responsive design
- VPS setup + DNS configuration

**Client deliverables required:**
- Logo + brand colour palette
- Website copy and content
- HD images — trucks, silos, batching plants, fleet, operations (drone photography preferred)
- Visual direction / reference websites
- Domain access for DNS configuration

---

### Phase 2 — Full Custom CMS Platform · R35,000 total *(Phase 1 included)*

Complete production system replacing the landing page. Built entirely from the ground up — no WordPress, no commercial CMS, no plugin stacks.

**Core structure:**
| Section | Description |
|---|---|
| Hero | Video or image carousel, CTAs, brand presentation |
| Navigation | Logo + up to 5 primary links, fully responsive |
| Services & Coverage | Regions, plant locations, delivery zones, operational areas |
| Clients / Projects | Expandable showcase, search-engine optimised |
| Metrics | Animated counters — clients served, cubes poured, projects completed |
| Calculator | Concrete cube volume estimator, attaches to leads |
| Lead Generation | Enquiry → CMS lead → admin email → user confirmation |

**CMS capabilities:**
- Editable homepage structure and internal page creation
- Banner + CTA management, structured page hierarchy
- Modular content system

**SEO framework (structural, not plugin-based):**
- Editable meta titles, descriptions, URL slugs
- Structured data support and SEO-friendly markup

**Required visual assets (HD professional quality):**
Concrete trucks · Silos · Batching plants · Operational yards · Equipment fleet · Service regions · Drone photography (if available)

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Django 6.0.2, Python 3.13 |
| Frontend | Bootstrap 5.3, Anime.js 4.3.6 |
| Database | PostgreSQL 17 (SQLite for local dev) |
| Cache / Sessions | Redis 7 (production) |
| Static files | WhiteNoise (all environments) |
| Reverse proxy | Traefik v3.3 |
| Container mgmt | Portainer CE |
| Deployment | Docker + Docker Compose |

---

## Repository Structure

```
├── Overberg_Readymix/
│   ├── settings/
│   │   ├── base.py          # Shared settings
│   │   ├── local.py         # Local development (SQLite, DEBUG on)
│   │   ├── staging.py       # Staging (Postgres, DEBUG off, local)
│   │   └── production.py    # Production (Postgres, Redis, Sentry)
│   ├── urls.py
│   ├── wsgi.py              # defaults → settings.production
│   └── asgi.py              # defaults → settings.production
├── dashboard/               # Core app
├── templates/               # Global templates
├── static/                  # Source static assets (anime.js, css, img)
├── staticfiles/             # Collected output (generated, gitignored)
├── requirements/
│   ├── base.txt
│   ├── local.txt
│   ├── staging.txt
│   └── production.txt
├── docker/
│   ├── traefik/             # Traefik stack (local + production)
│   └── portainer/           # Portainer stack (local + production)
├── docker-compose.yml
├── docker-compose.local.yml
├── docker-compose.staging.yml
├── docker-compose.production.yml
├── Dockerfile               # Multi-target: local / staging / production
└── scripts/
    └── entrypoint.sh        # migrate + collectstatic + gunicorn
```

---

## Local Development

### Prerequisites
- Docker Desktop
- Python 3.13 + venv (for running outside Docker)

### 1 — Start infrastructure stacks (once)

```bash
# Traefik reverse proxy
docker compose -f docker/traefik/docker-compose.local.yml up -d

# Portainer container management
docker compose -f docker/portainer/docker-compose.local.yml up -d
```

### 2 — Start the app

```bash
docker compose -f docker-compose.yml -f docker-compose.local.yml up --build
```

| Service | URL |
|---|---|
| App | http://overberg.localhost or http://localhost:8000 |
| Portainer | http://portainer.localhost or http://localhost:9000 |
| Traefik dashboard | http://traefik.localhost:8080 |

### 3 — Running outside Docker (PyCharm / terminal)

```bash
python -m venv .venv
.venv/Scripts/activate          # Windows
pip install -r requirements/local.txt
python manage.py migrate
python manage.py runserver
```

> `manage.py` defaults to `Overberg_Readymix.settings.local`
> PyCharm Django settings module: `Overberg_Readymix/settings/local.py`

---

## Staging

```bash
docker compose -f docker-compose.yml -f docker-compose.staging.yml up --build
```

App available at `http://overberg-staging.localhost`

---

## Production Deployment (Portainer)

1. Deploy Traefik stack via Portainer → `docker/traefik/docker-compose.production.yml`
2. Deploy Portainer stack (first deploy via CLI, then manage via UI)
3. Copy `.env.production.example` → `.env.production` on server and fill in all values
4. Deploy app stack from this repo using `docker-compose.production.yml`

---

## Environment Files

| File | Purpose | Committed |
|---|---|---|
| `.env.local` | Local dev defaults | ✅ Yes (no secrets) |
| `.env.staging` | Staging defaults | ✅ Yes (no secrets) |
| `.env.production.example` | Production template | ✅ Yes (no values) |
| `.env.production` | Live production secrets | ❌ Never |

---

## Maintenance & Support

| Package | Description | Cost |
|---|---|---|
| Basic Maintenance | VPS uptime, backups, updates, minor bug fixes | R750 / month |
| Extended Support | 3 hrs support, content updates, minor enhancements | From R1,500 / month |

---

## Hosting & Infrastructure

- VPS deployment with secure server configuration
- Traefik handles SSL termination (Let's Encrypt)
- WhiteNoise serves static files (no separate file server required)
- Domain DNS configuration required from client

---
