#!/bin/bash

# laravel app env

if [[ ! "$APP_ENV" ]]; then APP_ENV="production"; fi

if [[ ! "$APP_DEBUG" ]]; then APP_DEBUG="false"; fi
if [[ ! "$APP_LOG_LEVEL" ]]; then APP_LOG_LEVEL="debug"; fi
if [[ ! "$APP_URL" ]]; then APP_URL="http://localhost"; fi

# laraven db env

if [[ ! "$DB_CONNECTION" ]]; then DB_CONNECTION="mysql"; fi
if [[ ! "$DB_HOST" ]]; then DB_HOST="127.0.0.1"; fi
if [[ ! "$DB_PORT" ]]; then DB_PORT="3306"; fi
if [[ ! "$DB_DATABASE" ]]; then DB_DATABASE="laravel"; fi
if [[ ! "$DB_USERNAME" ]]; then DB_USERNAME="laravel"; fi
if [[ ! "$DB_PASSWORD" ]]; then DB_PASSWORD=""; fi

if [[ ! "$BROADCAST_DRIVER" ]]; then BROADCAST_DRIVER="log"; fi
if [[ ! "$CACHE_DRIVER" ]]; then CACHE_DRIVER="file"; fi
if [[ ! "$SESSION_DRIVER" ]]; then SESSION_DRIVER="file"; fi
if [[ ! "$QUEUE_DRIVER" ]]; then QUEUE_DRIVER="sync"; fi

# laravel redis env

if [[ ! "$REDIS_HOST" ]]; then REDIS_HOST="127.0.0.1"; fi
if [[ ! "$REDIS_PASSWORD" ]]; then REDIS_PASSWORD=""; fi
if [[ ! "$REDIS_PORT" ]]; then REDIS_PORT="6379"; fi

# laravel mail env

if [[ ! "$MAIL_DRIVER" ]]; then MAIL_DRIVER="smtp"; fi
if [[ ! "$MAIL_HOST" ]]; then MAIL_HOST="mailtrap.io"; fi
if [[ ! "$MAIL_PORT" ]]; then MAIL_PORT="2525"; fi
if [[ ! "$MAIL_USERNAME" ]]; then MAIL_USERNAME=""; fi
if [[ ! "$MAIL_PASSWORD" ]]; then MAIL_PASSWORD=""; fi
if [[ ! "$MAIL_ENCRYPTION" ]]; then MAIL_ENCRYPTION=""; fi

# laravel pusher env

if [[ ! "$PUSHER_APP_ID" ]]; then PUSHER_APP_ID=""; fi
if [[ ! "$PUSHER_KEY" ]]; then PUSHER_KEY=""; fi
if [[ ! "$PUSHER_SECRET" ]]; then PUSHER_SECRET=""; fi


cat >/var/www/html/.env <<EOF

APP_ENV=${APP_ENV}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG}
APP_LOG_LEVEL=${APP_LOG_LEVEL}
APP_URL=${APP_URL}

DB_CONNECTION=${DB_CONNECTION}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT}
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

BROADCAST_DRIVER=${BROADCAST_DRIVER}
CACHE_DRIVER=${CACHE_DRIVER}
SESSION_DRIVER=${SESSION_DRIVER}
QUEUE_DRIVER=${QUEUE_DRIVER}

REDIS_HOST=${REDIS_HOST}
REDIS_PASSWORD=${REDIS_PASSWORD}
REDIS_PORT=${REDIS_PORT}

MAIL_DRIVER=${MAIL_DRIVER}
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=${MAIL_ENCRYPTION}

PUSHER_APP_ID=${PUSHER_APP_ID}
PUSHER_KEY=${PUSHER_KEY}
PUSHER_SECRET=${PUSHER_SECRET}

EOF

cd /var/www/html
php7 /usr/bin/composer install
php7 artisan optimize

if [[ ! "$APP_KEY" ]]; then php7 artisan key:generate; fi

php7 artisan migrate --force