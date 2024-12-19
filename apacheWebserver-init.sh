#!/bin/bash

# Update der Paketliste
sudo apt update && sudo apt upgrade -y

# Installation von Apache
sudo apt install -y apache2

# Apache-Dienst starten
sudo systemctl unmask apache2
sudo systemctl start apache2
sudo systemctl enable apache2

sudo apt-get install -y libapache2-mod-php
sudo systemctl restart apache2.service

# Installation benötigter services für osTicket
sudo apt install -y php-mysql
