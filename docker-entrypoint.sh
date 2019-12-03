#!/bin/sh
set -e

hdfs namenode -format
start-all.sh