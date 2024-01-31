#!/bin/sh -e

echo "Installing from source"

export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install git vim sudo tzdata

mkdir -p /opt/
cd /opt/
git clone https://github.com/PentHertz/OpenBTS
cd OpenBTS

sed -i 's:/bin/sh:/bin/sh -e:' preinstall.sh
sed -i 's:apt install:apt install -y:' preinstall.sh
sed -i 's:build.sh:build.sh || true:' preinstall.sh

./preinstall.sh
./autogen.sh
./configure --with-uhd
make -j$(nproc)
make install
ldconfig

sed -i 's:socket.send(request):socket.send(request.encode("ascii")):' /opt/OpenBTS/NodeManager/nmcli.py
sed -i 's:+ response):+ response.decode()):' /opt/OpenBTS/NodeManager/nmcli.py

# try 3 times in case there are network issues
uhd_images_downloader || uhd_images_downloader || uhd_images_downloader
