"""
Local development settings.
Reads from .env.local — SQLite by default, DEBUG on, no SSL.
"""
from .base import *  # noqa

DEBUG = True

ALLOWED_HOSTS = ["*"]

# Use .env.local for local development
import environ
env = environ.Env()
environ.Env.read_env(BASE_DIR / ".env.local")

# Debug toolbar
INSTALLED_APPS += ["debug_toolbar"]
MIDDLEWARE.insert(0, "debug_toolbar.middleware.DebugToolbarMiddleware")
INTERNAL_IPS = ["127.0.0.1", "::1"]

# Console email
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# Disable manifest storage locally (no collectstatic needed)
STATICFILES_STORAGE = "django.contrib.staticfiles.storage.StaticFilesStorage"
