#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y mysql-server

sudo systemctl start mysql
sudo systemctl enable mysql
<<<<<<< HEAD
=======


>>>>>>> 96c160c (osTicket zip hochgeladen)
