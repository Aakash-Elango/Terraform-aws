#!/bin/bash
sudo su
NAME="aakash"
useradd $NAME
echo "trialpass" | passwd --stdin $NAME
chage -d 0 $NAME
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
exit