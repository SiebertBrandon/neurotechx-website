from __future__ import annotations
import os
from pathlib import Path
import environ

BASE_DIR = Path(__file__).resolve().parent.parent
env = environ.Env(
    DEBUG=(bool, False),
    SECRET_KEY=(str, "dev-insecure"),
)

# Load .env if present
environ.Env.read_env(os.path.join(BASE_DIR, ".env"))

DEBUG = env("DEBUG")
SECRET_KEY = env("SECRET_KEY")
ALLOWED_HOSTS = env.list(
    "ALLOWED_HOSTS",
    default=["localhost", "127.0.0.1", "0.0.0.0", "[::1]"],
)
ADMIN_EMAILS = [e.strip().lower() for e in env.list("ADMIN_EMAILS", default=[])]
ADMIN_EMAILS_SET = set(ADMIN_EMAILS)

# Security / proxy
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")
USE_X_FORWARDED_HOST = True

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "corsheaders",
    "neurotechx_site.core",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "neurotechx_site.middleware.traefik_remote_user.RemoteUserHeaderMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = "neurotechx_site.urls"
WSGI_APPLICATION = "neurotechx_site.wsgi.application"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / "neurotechx_site" / "core" / "templates"],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    }
]

DATABASES = {"default": env.db(default=f"sqlite:///{BASE_DIR / 'db.sqlite3'}")}

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"
    },
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

LANGUAGE_CODE = "en-us"
TIME_ZONE = "UTC"
USE_I18N = True
USE_TZ = True

STATIC_URL = "static/"
STATIC_ROOT = BASE_DIR / "staticfiles"
STORAGES = {
    "staticfiles": {
        "BACKEND": "whitenoise.storage.CompressedManifestStaticFilesStorage"
    },
}

# CSRF / Cookies (tune for your domain)
CSRF_TRUSTED_ORIGINS = env.list(
    "CSRF_TRUSTED_ORIGINS",
    default=["http://localhost:8000", "http://127.0.0.1:8000"],
)
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True

# CORS (if your React app is on another host)
CORS_ALLOWED_ORIGINS = [
    f"https://{h}" for h in os.getenv("CORS_HOSTS", "").split(",") if h
]

# How oauth2-proxy / Traefik pass identity (headers)
REMOTE_USER_HEADER = os.getenv(
    "REMOTE_USER_HEADER", "HTTP_X_AUTH_REQUEST_EMAIL"
)  # default
REMOTE_NAME_HEADER = os.getenv("REMOTE_NAME_HEADER", "HTTP_X_AUTH_REQUEST_USER")
ADMIN_EMAILS_SET = set(ADMIN_EMAILS)
