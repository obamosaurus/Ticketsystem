#!/bin/bash

# benutzereingaben verhindern
export DEBIAN_FRONTEND=noninteractive

# needrestart: services neustarten ohne Daemons popup
sudo sh -c 'echo "\$nrconf{restart} = '\''a'\'';" > /etc/needrestart/conf.d/99-restart-auto.conf'

# Update der Paketliste
sudo apt update && sudo apt upgrade -y

# Installation von Apache
sudo apt install -y apache2

# Apache-Dienst starten
sudo systemctl unmask apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Installation benötigter services für osTicket
sudo apt install -y php-mysql
sudo apt-get install -y mysql-client 


sudo apt-get install -y libapache2-mod-php
sudo systemctl restart apache2.service


