#!/bin/sh -e

echo "Installing from source"

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y build-essential git mdm lsb-release sudo wget psmisc

# optional
apt-get install -y vim nmap tcpdump iputils-ping iproute2 netcat

# Following https://github.com/RangeNetworks/dev/wiki
mkdir -p /opt/
cd /opt/
git clone https://github.com/RangeNetworks/dev.git openbts-dev

cd /opt/openbts-dev
#./switchto.sh master
./switchto.sh v4.0.0
./clone.sh
./build.sh B210

# prevent resolvconf failure
echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

# this will fail because of missing deps
dpkg --force-confnew -i BUILDS/*/*.deb || true
apt-get -y -o Dpkg::Options::="--force-confnew" -f install

uhd_images_downloader

# setup some permissions
mkdir -p /var/run/OpenBTS /var/run/rrlp /var/lib/OpenBTS /var/lib/asterisk/sqlite3dir /var/run/asterisk
chmod 777 /var/run/rrlp
chown -R asterisk:www-data /var/lib/asterisk/sqlite3dir
chmod 775 /var/lib/asterisk/sqlite3dir
#chmod 664 /var/lib/asterisk/sqlite3dir/sqlite3*
chown asterisk: /var/run/asterisk

