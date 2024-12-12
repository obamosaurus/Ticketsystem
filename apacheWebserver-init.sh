#!/bin/bash

# Installation von Apache
sudo apt install -y apache2

# Apache-Dienst starten
sudo systemctl unmask apache2
sudo systemctl start apache2
sudo systemctl enable apache2
