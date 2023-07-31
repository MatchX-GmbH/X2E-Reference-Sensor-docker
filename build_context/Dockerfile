FROM ubuntu:20.04
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    sudo vim openssl net-tools \
    git wget flex bison gperf python3 python3-pip python3-setuptools cmake \
    ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 \
    python-is-python3

RUN mkdir -p /opt2/esp32 && cd /opt2/esp32 && git clone -b v4.4.4 --recursive https://github.com/espressif/esp-idf.git

RUN groupadd -g 1000 developer0 && \
    useradd -g 1000 -m -s /bin/bash -u 1000 developer0 && \
    usermod --password $(openssl passwd -1 123456) developer0 && \
    echo "developer0	ALL=(ALL:ALL) ALL" >> /etc/sudoers

RUN groupadd -g 1001 developer1 && \
    useradd -g 1001 -m -s /bin/bash -u 1001 developer1 && \
    usermod --password $(openssl passwd -1 123456) developer1 && \
    echo "developer1	ALL=(ALL:ALL) ALL" >> /etc/sudoers

RUN echo "# Increase Inotify limits for GitKraken" >> /etc/sysctl.conf
RUN echo "fs.inotify.max_user_watches=99999" >> /etc/sysctl.conf


RUN echo "# Setup for ESP32" >> /etc/skel/.bashrc
RUN echo "[ -e ~/.espressif ] && . /opt2/esp32/esp-idf/export.sh" >> /etc/skel/.bashrc
RUN echo "echo \"Run 'sudo chmod 666 /dev/ttyACM0' to allow flashing the device.\"" >> /etc/skel/.bashrc

COPY start.sh /start.sh
ENTRYPOINT /start.sh
