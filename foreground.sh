#!/bin/bash

publicIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo "ServerName $publicIp" >> /etc/apache2/apache2.conf

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
