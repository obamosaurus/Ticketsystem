#!/bin/bash

# benutzereingaben verhindern
export DEBIAN_FRONTEND=noninteractive


# needrestart: services neustarten ohne Daemons popup
sudo sh -c 'echo "\$nrconf{restart} = '\''a'\'';" > /etc/needrestart/conf.d/99-restart-auto.conf'


# apt updaten und upgrade
sudo apt update
sudo apt upgrade -y


# MySQL installieren
sudo apt install -y mysql-server


# MySQL service starten und aktivieren
sudo systemctl start mysql
sudo systemctl enable mysql


sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^mysqlx-bind-address\s*=.*/mysqlx-bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql

# DB erstellen und root user passwort setzen
sudo mysql -e "CREATE DATABASE osTicketDB; \
               ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Riethuesli>12345!';
               CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'Riethuesli>12345!';
               GRANT ALL PRIVILEGES ON osTicketDB.* TO 'root'@'%' WITH GRANT OPTION;
               FLUSH PRIVILEGES;"
