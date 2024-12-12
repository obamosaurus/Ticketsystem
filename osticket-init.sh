#!/bin/bash

sudo apt install -y unzip
unzip osTicket-v1.18.1.zip
mv osTicket-v1.18.1 /var/www/html/osTicket
chown -R www-data:www-data /var/www/html/osTicket
