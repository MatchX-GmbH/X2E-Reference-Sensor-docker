#! /bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

container_name=x2e_ref-dev

echo "Entering container..."
env CURRENT_USER=$(id -u):$(id -g) docker-compose exec ${container_name} bash
