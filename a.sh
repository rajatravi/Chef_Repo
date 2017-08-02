#!/bin/bash

while :
do
date_time=`date -u | cut -d ' ' -f2-4`
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Accepted publickey for rajat from 192.168.33.1 port 50816 ssh2: RSA 34:e6:55:b3:69:06:6c:55:42:c2:b3:02:22:b8:3c:d6" >> /var/log/auth.log
sleep 2s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Accepted publickey for rajat from 192.168.33.1 port 50816 ssh2: RSA 34:e6:55:b3:69:06:6c:55:42:c2:b3:02:22:b8:3c:d6" >> /var/log/auth.log
sleep 3s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Failed password for rajat from 192.168.33.1 port 50742 ssh2" >> /var/log/auth.log
sleep 2s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Failed password for rajat from 192.168.33.1 port 50742 ssh2" >> /var/log/auth.log
sleep 1s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Failed password for rajat from 192.168.33.1 port 50742 ssh2" >> /var/log/auth.log
sleep 1s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Failed password for rajat from 192.168.33.1 port 50742 ssh2" >> /var/log/auth.log
sleep 4s
echo "$date_time vagrant-ubuntu-trusty-64 sshd[24302]: Failed password for rajat from 192.168.33.1 port 50742 ssh2" >> /var/log/auth.log

sleep 1
done
