#!/bin/bash -e

sqlite3 /etc/OpenBTS/OpenBTS.db <<EOF
update CONFIG set VALUESTRING="901" where KEYSTRING="GSM.Identity.MCC";
update CONFIG set VALUESTRING="70" where KEYSTRING="GSM.Identity.MNC";
update CONFIG set VALUESTRING="NinjaTelCo" where KEYSTRING="GSM.Identity.ShortName";
update CONFIG set VALUESTRING="10" where KEYSTRING="GSM.Radio.RxGain";
update CONFIG set VALUESTRING="^90170" where KEYSTRING="Control.LUR.OpenRegistration";
update CONFIG set VALUESTRING="0" where KEYSTRING="GSM.Radio.PowerManager.MaxAttenDB";
update CONFIG set VALUESTRING="1" where KEYSTRING="GPRS.Enable";
update CONFIG set VALUESTRING="0" where KEYSTRING="GGSN.Firewall.Enable";
EOF

sipauthserve &

for i in `seq 510 519`; 
do 
	/opt/OpenBTS/NodeManager/nmcli.py sipauthserve subscribers create ue$i IMSI901700000038$i $i; 
done

# chown asterisk: /var/lib/asterisk/sqlite3dir/*

cat > /etc/odbcinst.ini <<EOF
[SQLite]
Description=SQLite ODBC Driver
Driver=libsqliteodbc.so
Setup=libsqliteodbc.so
UsageCount=1

[SQLite3]
Description=SQLite3 ODBC Driver
Driver=libsqlite3odbc.so
Setup=libsqlite3odbc.so
UsageCount=1
EOF
