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

#mail tools I need
sudo yum install postfix cyrus-sasl cyrus-sasl-plain cyrus-sasl-md5 cyrus-sasl-gssapi cyrus-sasl-scram

#fail2ban
sudo yum install fail2ban

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

vi /etc/aliases # add external mail address
newaliases



