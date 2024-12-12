#!/bin/bash

# Update der Paketliste
sudo apt update && sudo apt upgrade -y

# Installation von mysql
sudo apt install -y mysql-server

# mysql Server starten 
sudo systemctl start mysql
sudo systemctl enable mysql
