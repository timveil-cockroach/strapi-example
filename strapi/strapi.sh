#!/bin/sh

set -ea

cd /usr/src/api

APP_NAME=${APP_NAME:-strapi-app}
DATABASE_CLIENT=${DATABASE_CLIENT:-postgres}
DATABASE_HOST=${DATABASE_HOST:-localhost}
DATABASE_PORT=${DATABASE_PORT:-26257}
DATABASE_NAME=${DATABASE_NAME:-strapi}
DATABASE_SRV=${DATABASE_SRV:-false}
EXTRA_ARGS=${EXTRA_ARGS:-}

if [ ! -f "$APP_NAME/package.json" ]
then
    echo "**************** creating new app ****"
    strapi new ${APP_NAME} --dbclient=$DATABASE_CLIENT --dbhost=$DATABASE_HOST --dbport=$DATABASE_PORT --dbsrv=$DATABASE_SRV --dbname=$DATABASE_NAME --dbusername=$DATABASE_USERNAME --dbpassword=$DATABASE_PASSWORD --dbssl=$DATABASE_SSL --dbauth=$DATABASE_AUTHENTICATION_DATABASE $EXTRA_ARGS
elif [ ! -d "$APP_NAME/node_modules" ]
then
    echo "**************** npm install app ****"
    npm install --prefix ./$APP_NAME
fi

cd $APP_NAME

echo "**************** strapi start ****"
strapi start &

strapiPID=$!

echo "**************** wait $strapiPID ****"
wait "$strapiPID"