#!/bin/sh
set -e

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

hdfs namenode -format
start-all.sh


while true; do sleep 1000; done
