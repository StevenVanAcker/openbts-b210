#!/bin/sh

/usr/sbin/asterisk -U asterisk -g -f &
sleep 1

cd /OpenBTS
./sipauthserve &
./smqueue &
./OpenBTS
