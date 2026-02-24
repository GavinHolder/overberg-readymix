"""
Staging settings.
Mirrors production behaviour but runs locally (no SSL, no Sentry).
"""
from .base import *  # noqa

import environ
env = environ.Env()
environ.Env.read_env(BASE_DIR / ".env.staging")

DEBUG = False

ALLOWED_HOSTS = env.list("DJANGO_ALLOWED_HOSTS", default=["localhost", "127.0.0.1"])

# Console email (no real sending in staging)
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# Stricter security (test production headers locally)
SECURE_BROWSER_XSS_FILTER = True
X_FRAME_OPTIONS = "DENY"
