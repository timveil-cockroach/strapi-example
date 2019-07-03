#!/bin/bash

docker-compose build --no-cache

docker-compose up --no-start

docker-compose start crdb


sleep 5

docker-compose exec crdb /cockroach/cockroach sql --insecure --execute="CREATE DATABASE strapi;"
docker-compose exec crdb /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING server.remote_debugging.mode = \"any\";"

sleep 5


docker-compose start strapi
