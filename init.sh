#!/bin/sh

#/usr/sbin/asterisk -U asterisk -g -f &
#sleep 1

smqueue &
sipauthserve &

cd /OpenBTS
./OpenBTS
