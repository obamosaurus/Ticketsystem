#!/bin/bash
wget https://github.com/osTicket/osTicket/releases/download/v1.18.17/osTicket-v1.18.17.zip
unzip osTicket-v1.18.17.zip
mv osTicket-v1.18.17 /var/www/html/osTicket
chown -R www-data:www-data /var/www/html/osTicket
