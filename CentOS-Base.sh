#!/bin/bash

# do not run - notes on initial setup
# todo add to kickstart

# stop the damn beeping
echo "blacklist pcspkr" >> /etc/modprobe.d/pcspkr.conf

# update the system
sudo yum update -y

# add epel repo
sudo yum install -y epel-release

#screen
sudo yum install screen

#fail2ban
sudo yum install fail2ban
#Configure fail2ban

#mail tools I need
sudo yum install postfix mailx cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5 cyrus-sasl-gssapi cyrus-sasl-scram
#postfix config for gmail
echo "smtp.gmail.com    smtp_user:smtp_passwd" > /etc/postfix/sasl_passwd
postmap hash:/etc/postfix/sasl_passwd
# append to /etc/postfix/main.cf
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
## Secure channel TLS with exact nexthop name match.
# smtp_tls_security_level = secure
smtp_tls_mandatory_protocols = TLSv1
smtp_tls_mandatory_ciphers = high
smtp_tls_secure_cert_match = nexthop
smtp_tls_CAfile = /etc/pki/tls/certs/ca-bundle.crt
relayhost = smtp.gmail.com:587
postfix reload
# add external mail address
vi /etc/aliases 
newaliases

#install qemu/kvm 
dnf install qemu-kvm qemu-img libvirt virt-install libvirt-client
systemctl start libvirtd
systemctl enable libvirtd
#test qemu/kvm one-liner
virt-install --connect qemu:///system -n centos7 --ram 1024 --disk /var/lib/libvirt/images/centos7.img,size=8 --vcpus 1 --os-type linux --os-variant centos7.0 --graphics none --console pty,target_type=serial --location /var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1908.iso --extra-args='console=ttyS0'


