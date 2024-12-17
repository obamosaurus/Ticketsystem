#!/bin/bash

#install unzip
sudo apt install -y unzip

#unzip and move osTicket
unzip osTicket-v1.18.1.zip
mkdir -p /var/www/html/osTicket
sudo mv osTicket-v1.18.1 /var/www/html/

#ChangeOwner to www-data
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 777 /var/www.html/
