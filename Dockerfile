# syntax=docker/dockerfile:1
FROM python:3.13-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# System deps (PostgreSQL client libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# ── Production image ────────────────────────────────────────────────────────
FROM base AS production

COPY requirements/production.txt requirements/production.txt
RUN pip install -r requirements/production.txt

COPY . .

# Copy entrypoint script and make executable
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Collect static files (anime.js, css, etc.) — uses dummy DB_URL, no DB hit
RUN DJANGO_SETTINGS_MODULE=Overberg_Readymix.settings.production \
    DJANGO_SECRET_KEY=build-time-dummy-secret \
    DATABASE_URL=sqlite:////tmp/build.sqlite3 \
    DJANGO_ALLOWED_HOSTS=localhost \
    python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]

# ── Staging image ────────────────────────────────────────────────────────────
FROM base AS staging

COPY requirements/staging.txt requirements/staging.txt
RUN pip install -r requirements/staging.txt

COPY . .
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]

# ── Local/dev image ──────────────────────────────────────────────────────────
FROM base AS local

COPY requirements/local.txt requirements/local.txt
RUN pip install -r requirements/local.txt

COPY . .

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
