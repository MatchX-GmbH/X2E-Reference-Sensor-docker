#! /bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

container_name=x2e_ref-dev

# Check dir
cd $script_dir
if [ ! -e ../working ]; then
    mkdir ../working
fi
if [ ! -e ./home ]; then
    mkdir home
fi
if [ ! -e ./opt ]; then
    mkdir opt
fi

# Up
cd ${script_dir}
env CURRENT_USER=$(id -u):$(id -g) docker-compose up -d $1

# Show Info
echo " "
echo "The user password is 123456."
echo " "

echo -en "\033]0; ${container_name} \a"
echo "Entering container..."
env CURRENT_USER=$(id -u):$(id -g) docker-compose exec ${container_name} bash
