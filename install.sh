#!/bin/bash

# esp mdf repository version
esp_mdf_version="$1"
esp_mdf_commit="$2"

# Installing prerequisites
echo "## Install prerequisites"

sudo DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util

# Making Python 3 the default interpreter
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Create the esp directory for repo download
mkdir ~/esp
cd ~/esp

echo "## Download esp-mdf repository"

if [ -n "$esp_mdf_commit" ]
then
    git clone --recursive https://github.com/espressif/esp-mdf.git
    cd ~/esp/esp-mdf
    git reset --hard $esp_mdf_commit
    git submodule --init --recursive
else
    case $esp_mdf_version in
        latest)
            # Clone esp mdf master branch repository
            git clone --recursive https://github.com/espressif/esp-mdf.git
            ;;
        *)
            # Clone esp mdf repository
            wget https://dl.espressif.com/dl/esp-mdf/releases/esp-mdf-$esp_mdf_version.zip

            # Extract the files and rename folder
            unzip -q esp-mdf-$esp_mdf_version.zip && mv esp-mdf-$esp_mdf_version esp-mdf
            rm -f esp-mdf-$esp_mdf_version.zip
            ;;
    esac
fi
# Navigate to esp mdf repository
cd ~/esp/esp-mdf

# Installing tools
echo "## Install esp-mdf tools"

# Install required tools
./esp-idf/install.sh