#!/bin/bash
wget https://github.com/osTicket/osTicket/releases/download/v1.18.1/osTicket-v1.18.1.zip
unzip osTicket-v1.18.1.zip
mv osTicket-v1.18.1 /var/www/html/osTicket
chown -R www-data:www-data /var/www/html/osTicket
