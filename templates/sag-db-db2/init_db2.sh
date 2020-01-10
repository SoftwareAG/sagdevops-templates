#!/bin/sh
 
echo '------------------------------------------'
echo 'start setting up webm db'
 
# become db2inst1 user
sudo -i -u db2inst1 bash << EOF
 
# create "webm" database
db2 create database webm using codeset UTF-8 territory DE pagesize 32768
db2 update database configuration for webm using LOGFILSIZ 8192 LOGPRIMARY 40 LOGSECOND 20 applheapsz 60000
 
db2 connect to webm
# Grant "webm" user all rights on "webm" database
db2 grant DATAACCESS on webm to user webm
 
db2 connect reset
 
echo 'done setting up webm db'
echo '------------------------------------------'
 
EOF
