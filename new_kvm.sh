#!/bin/bash

#pre-req kvm 'default' storage pool defined, location of ks.cfg and iso

# Update kickstart file with hostname and IP address
echo -en "Enter Hostname: "
read HOST_NAME
echo -en "Enter IP Address: "
read IP_ADDRESS
sudo sed -i 's/server1/'$HOST_NAME'/g' /var/www/html/kickstart/ks.cfg
sudo sed -i 's/192.168.122.100/'$IP_ADDRESS'/g' /var/www/html/kickstart/ks.cfg

# Pre-defined variables
echo ""
MEM_SIZE=1024
VCPUS=1
OS_VARIANT="rhel7"
ISO_FILE="/var/www/html/kickstart/CentOS-7-x86_64-Minimal-1511.iso"


echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE

sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --network bridge=virbr0  \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --console pty,target_type=serial \
     -x 'console=ttyS0,115200n8 serial' \
     -x "ks=http://192.168.122.1/kickstart/ks.cfg"
