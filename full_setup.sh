#!/bin/bash
set -e

# wget https://raw.githubusercontent.com/DonLakeFlyer/MavlinkTagController/main/full_setup.sh

echo "*** Install tools"
sudo apt install build-essential
sudo apt install git cmake build-essential libboost-all-dev airspy libfftw3-dev -y

echo "*** Create repos directory"
cd ~
if [ ! -d repos ]; then
    mkdir repos
fi
cd ~/repos

echo "*** Clone and build MavlinkTagController"
cd ~/repos
if [ ! -d MavlinkTagController ]; then
	git clone --recursive git@github.com:DonLakeFlyer/MavlinkTagController.git
fi
cd ~/repos/MavlinkTagController
git pull origin main
cmake -Bbuild -H. 
cmake --build build -j4

echo "*** Clone and build csdr-uavrt"
cd ~/repos
if [ ! -d csdr-uavrt ]; then
	git clone --recursive git@github.com:DonLakeFlyer/csdr-uavrt.git
fi
cd ~/repos/csdr-uavrt
git pull origin master
make -j4
sudo make install

echo "*** Clone and build airspy_channelize"
cd ~/repos
if [ ! -d airspy_channelize ]; then
	git clone --recursive -b don-codegen git@github.com:dynamic-and-active-systems-lab/airspy_channelize.git
fi
cd ~/repos/airspy_channelize
git pull origin don-codegen
make -f matlab-coder-utils/Makefile PRODUCT_NAME=airspy_channelize -j4

echo "*** Clone and build uavrt_detection"
cd ~/repos
if [ ! -d uavrt_detection ]; then
	git clone --recursive -b don-codegen git@github.com:dynamic-and-active-systems-lab/uavrt_detection.git
fi
cd ~/repos/uavrt_detection
git pull origin don-codegen
make -f matlab-coder-utils/Makefile PRODUCT_NAME=uavrt_detection -j4
