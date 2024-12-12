#!/bin/bash

#install unzip
sudo apt install -y unzip

#unzip and move osTicket
unzip osTicket-v1.18.1.zip
mkdir -p /var/www/html/osTicket
mv osTicket-v1.18.1 /var/www/html/osTicket

#ChangeOwner to www-data
chown -R www-data:www-data /var/www/html/osTicket
