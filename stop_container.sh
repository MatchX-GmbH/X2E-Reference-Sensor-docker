#! /bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd ${script_dir}
env CURRENT_USER=$(id -u):$(id -g) docker-compose down
