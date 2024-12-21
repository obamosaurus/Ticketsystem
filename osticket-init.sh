#!/bin/bash

sudo apt install -y unzip

# osTicket unzip nach /tmp/osTicket
unzip ~/Ticketsystem/osTicket-v1.18.1.zip -d /tmp/osTicket
sudo rm -rf /tmp/osTicket/osTicket-v1.18.1/scripts

# index.html vom webserver löschen
sudo rm -f /var/www/html/index.html

# inhalt von ../uploads/ in webserver moven 
sudo mv /tmp/osTicket/osTicket-v1.18.1/upload/* /var/www/html/

# Besitzer und Dateiberechtigungen anpassen
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# tmp Dateien löschen
rm -rf /tmp/osTicket

# ZIP-Datei und Zone.Identifier aus Home löschen
rm -f ~/osTicket-v1.18.1.zip
rm -f ~/osTicket-v1.18.1.zip\:Zone.Identifier

# config file vorbereiten
cd /var/www/html/include/
sudo cp ost-sampleconfig.php /var/www/html/include/ost-config.php
sudo chmod 0666 ost-config.php
