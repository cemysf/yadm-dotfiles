#!/usr/bin/env bash

container_name='portainer'
port='9000'
url="http://localhost:${port}/"

# img="portainer/portainer" # Deprecated!
img="portainer/portainer-ce"

if [ ! "$(docker ps -q -f name=${container_name})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${container_name})" ]; then
        # cleanup
        docker rm ${container_name}
    fi
    # run your container
    echo "Starting portainer at ${url}...";

    docker pull ${img};

    docker run                                     \
      --detach                                     \
      --rm                                         \
      -p 8000:8000                                 \
      -p 9000:${port}                              \
      --name=${container_name}                     \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data                      \
      ${img}
else
    echo "Already running!";
    echo "Check: ${url}";
fi

