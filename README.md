# X2E development environment (Docker for ESP32)

This is the development environment for X2E Reference Sensor. The development are mainly performed inside the docker container.



*The following operations are tested on a Ubuntu 20.04 LTS machine. Minor adjustments may be needed for other machines.*

# Set up of the environment

Assume the working directory is ```/home/you/matchx_dev```.

1. Create the network interface for the docker container.

   ```
   docker network create -o "com.docker.network.bridge.name"="docker99" --subnet=172.99.0.0/16 docker99
   ```

   

2. Create the directory and check out the repos.

   ```
   mkdir ~/matchx_dev
   cd ~/matchx_dev
   git clone git@gitlab.com:matchx/nft-beacon/x2e_ref-dev-docker.git
   ```

   

3. Connect the development board and start the docker container at the host computer.

   ```
   cd x2e_ref-dev-docker
   ./start_container.sh
   ```

   *The steps after here will execute inside the docker container.*

   

4. Setup the HOME directory

   ```
   mkdir "$HOME"
   cp -rT /etc/skel/ "$HOME"
   ```

   

5. Set the git user info.

   ```
   git config --global user.name "YOUR NAME"
   git config --global user.email "YOUR EMAIL"
   ```

   And modify the ```~/.ssh/config``` to set up the private cert for accessing the MatchX GitLab.

   

6. Create a ```.netrc``` file at the HOME directory and set the login information for HTTPS access of MatchX GitLab.

   ```
   machine gitlab.com
       login HTTPS_LOGIN
       password GIT_ACCESS_TOKEN
   ```

   

7. Setup ESP32

   ```
   /opt2/esp32/esp-idf/install.sh
   ```

   

8. Add exception for the esp32 directory to git.

   ```
   git config --global --add safe.directory /opt2/esp32/esp-idf
   ```

   

9. Run `exit` to exit the docker container, then run `./enter_container.sh` to enter the container again.

   

10. Clone the project.

    ```
    cd /working
    git clone --recurse-submodules git@gitlab.com:matchx/x2e_reference_sensor/x2e_ref-firmware.git
    ```

       

11. Set the target for the project (example_device).

    ```
    cd /working/x2e_ref-firmware/example_device
    idf.py set-target esp32s3
    ```

       

11. Build the project

    ```
    idf.py build
    ```

       

12. If the connected device is not /dev/ttyACM0, then you need to manually change the permission. For example /dev/ttyACM1, then you need to chmod for this.
    ```
    sudo chmod 666 /dev/ttyACM1
    ```

    

13. Download to the target.

    ```
    idf.py flash -d /dev/ttyACM0
    ```

    


The working directory inside the container will has the structure shown below.

```
/working
  |-- x2e_ref-firmware       (X2E Ref Sensor Firmwares)
        |-- example_device   (An example of LoRa device)
```



# Helper scripts at the host computer

| File               | Description                                                  |
| ------------------ | ------------------------------------------------------------ |
| start_container.sh | Start and persist the container.<br />After the start, it will enter the container with bash shell. |
| stop_container.sh  | Stop the container.                                          |
| enter_container.sh | Enter the container with bash shell.                         |



# Mapped directories

| Directory | Container Location | Description |
|-----------|----------|-------------|
| ../working | /working           | The container working directory. |
| home       | /home              | Home directory for users.        |
| opt | /opt |  |
| archives | /archives |  |

