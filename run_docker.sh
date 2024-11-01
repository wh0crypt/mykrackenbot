#!/bin/bash

# Script that checks and sets the container up

CONTAINER_NAME="kracken"

if [ "$(sudo docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "Deleting the existing container: $CONTAINER_NAME"
  sudo docker-compose down
else
  echo "THe container '$CONTAINER_NAME' does not exists."
fi

sudo docker-compose build --no-cache
sudo docker-compose up -d --remove-orphans
