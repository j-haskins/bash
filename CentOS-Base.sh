#!/bin/bash

# do not run - notes on initial setup

# stop the damn beeping
echo "blacklist pcspkr" >> /etc/modprobe.d/pcspkr.conf

# update the system
sudo yum update -y

# add epel repo
sudo yum install -y epel-release
