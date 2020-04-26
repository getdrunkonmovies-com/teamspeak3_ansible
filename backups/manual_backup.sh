#!/bin/bash

old_pwd=$(pwd)

DATE=`date +"%m-%d-%y"`

cd $BASE_DIR
ssh -t -i "${old_pwd}/ssh_keys/${2}_rsa" $2@$1 mkdir -p /data/backup/teamspeak3
ssh -t -i "${old_pwd}/ssh_keys/${2}_rsa" $2@$1 bash -c "cd /data/backup/teamspeak3 && sudo rm /data/backup/teamspeak3/manual_backup_${DATE}.zip && sudo zip -r /data/backup/teamspeak3/manual_backup_${DATE}.zip /data/ansible/teamspeak3/data/"
scp -i "${old_pwd}/ssh_keys/${2}_rsa" $2@$1:/data/backup/teamspeak3/manual_backup_${DATE}.zip manual_backup_${DATE}.zip