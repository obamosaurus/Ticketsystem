#!/bin/bash

### AWS-Instance-init.sh ### START

# VPC erstellen
echo "Erstelle VPC..."
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --query 'Vpc.VpcId' \
  --output text)
echo "VPC erstellt. VPC ID: $VPC_ID"

# Warten, bis die VPC verfuegbar ist
echo "Warte auf die VPC-Verfuegbarkeit..."
aws ec2 wait vpc-available --vpc-ids $VPC_ID

# Tag der VPC setzen
aws ec2 create-tags \
  --resources $VPC_ID \
  --tags Key=Name,Value=AutoVPC
echo "VPC getaggt als 'AutoVPC'."



# Subnetz erstellen
echo "Erstelle Subnetz..."
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block 10.0.1.0/24 \
  --query 'Subnet.SubnetId' \
  --output text)
echo "Subnetz erstellt. Subnet ID: $SUBNET_ID"

# Warten, bis das Subnetz verfuegbar ist
echo "Warte auf die Subnetz-Verfuegbarkeit..."
aws ec2 wait subnet-available --subnet-ids $SUBNET_ID

# Tag des Subnetzes setzen
aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags Key=Name,Value=AutoSubnet
echo "Subnetz getaggt als 'AutoSubnet'."



# Internet-Gateway erstellen und an VPC anhaengen
echo "Erstelle Internet-Gateway..."
IGW_ID=$(aws ec2 create-internet-gateway \
  --query 'InternetGateway.InternetGatewayId' \
  --output text)
echo "Internet-Gateway erstellt. IGW ID: $IGW_ID"

aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID
echo "Internet-Gateway an die VPC angehaengt."



# Routing-Tabelle erstellen und Route zu 0.0.0.0/0 hinzufuegen
echo "Erstelle Routing-Tabelle..."
ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.RouteTableId' \
  --output text)
echo "Routing-Tabelle erstellt. Route Table ID: $ROUTE_TABLE_ID"

aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID
echo "Route zu 0.0.0.0/0 hinzugefuegt."

# Subnetz mit Routing-Tabelle verknuepfen
aws ec2 associate-route-table \
  --subnet-id $SUBNET_ID \
  --route-table-id $ROUTE_TABLE_ID
echo "Subnetz mit der Routing-Tabelle verknuepft."

echo "VPC und Subnetz wurden erfolgreich erstellt."
echo "VPC ID: $VPC_ID"
echo "Subnetz ID: $SUBNET_ID"



# SSH-Key erstellen
echo "Erstelle SSH-Key..."
mkdir -p ~/.ssh
aws ec2 create-key-pair \
  --key-name osTicketGroupTFD_key \
  --key-type rsa \
  --query 'KeyMaterial' \
  --output text > ~/.ssh/osTicketGroupTFD_key.pem

chmod 600 ~/.ssh/osTicketGroupTFD_key.pem
echo "SSH-Key erstellt und gespeichert unter ~/.ssh/osTicketGroupTFD_key.pem"

# Key-Pfad definieren
KEY_PATH="$HOME/.ssh/osTicketGroupTFD_key.pem"



# 2) Security Group erstellen
echo "Erstelle Security Group..."
GROUP_ID=$(aws ec2 create-security-group \
  --group-name osTicketGroupTFD_secGroup \
  --description "EC2-M364 sec-group" \
  --vpc-id $VPC_ID \
  --query 'GroupId' \
  --output text)
echo "Security Group erstellt. Group ID: $GROUP_ID"



# Sicherheitsregeln setzen
# TCP 80 (HTTP)
echo "Autorisiere Sicherheitsregeln fuer Port 80 (HTTP)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0
echo "Port 80 (HTTP) autorisiert."

# TCP 22 (SSH)
echo "Autorisiere Sicherheitsregeln fuer Port 22 (SSH)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
echo "Port 22 (SSH) autorisiert."

# TCP 3306 (MySQL) innerhalb der VPC
echo "Autorisiere Sicherheitsregeln fuer Port 3306 (MySQL)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 3306 \
  --cidr 10.0.0.0/16
echo "Port 3306 (MySQL) autorisiert."

# ICMP (Ping) innerhalb der VPC
echo "Autorisiere ICMP (Ping) innerhalb der VPC..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol icmp \
  --port -1 \
  --cidr 10.0.0.0/16
echo "ICMP (Ping) autorisiert."



# EC2-Instanzen erstellen
AMI_ID="ami-08c40ec9ead489470"
INSTANCE_TYPE="t2.micro"
IAM_PROFILE="LabInstanceProfile"

echo "Starte dbServer-Instanz..."
DB_INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name osTicketGroupTFD_key \
  --security-group-ids $GROUP_ID \
  --subnet-id $SUBNET_ID \
  --associate-public-ip-address \
  --iam-instance-profile Name=$IAM_PROFILE \
  --private-ip-address 10.0.1.135 \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=dbServer}]" \
  --query 'Instances[0].InstanceId' \
  --output text)
echo "dbServer-Instanz gestartet. Instance ID: $DB_INSTANCE_ID"

echo "Starte webServer-Instanz..."
WEB_INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name osTicketGroupTFD_key \
  --security-group-ids $GROUP_ID \
  --subnet-id $SUBNET_ID \
  --associate-public-ip-address \
  --iam-instance-profile Name=$IAM_PROFILE \
  --private-ip-address 10.0.1.136 \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=webServer}]" \
  --query 'Instances[0].InstanceId' \
  --output text)
echo "webServer-Instanz gestartet. Instance ID: $WEB_INSTANCE_ID"

echo ""
echo "Alle Schritte abgeschlossen!"
echo "VPC ID: $VPC_ID"
echo "Subnetz ID: $SUBNET_ID"
echo "Security Group ID: $GROUP_ID"
echo "dbServer ID: $DB_INSTANCE_ID"
echo "webServer ID: $WEB_INSTANCE_ID"


# Warten, bis die beiden Instanzen im Status "running" sind
aws ec2 wait instance-running --instance-ids "$DB_INSTANCE_ID" "$WEB_INSTANCE_ID"

# Public IP-Adressen in Variablen speichern
DB_PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$DB_INSTANCE_ID" \
  --query "Reservations[].Instances[].PublicIpAddress" \
  --output text)

WEB_PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$WEB_INSTANCE_ID" \
  --query "Reservations[].Instances[].PublicIpAddress" \
  --output text)

# Ausgeben der Public IP-Adressen
echo "dbServer Public IP: $DB_PUBLIC_IP"
echo "webServer Public IP: $WEB_PUBLIC_IP"



### AWS-Instance-init.sh ### END
# ----------------------------------------
### database-init.sh ### START


# SSH-Verbindung zum dbServer herstellen und Befehle remote ausführen
ssh -o StrictHostKeyChecking=no \
    -i "$HOME/.ssh/osTicketGroupTFD_key.pem" \
    ubuntu@"$DB_PUBLIC_IP" << 'EOF'

# --- Beginn der Remote-Befehle ---

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

# MySQL auf alle Interfaces binden
sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^mysqlx-bind-address\s*=.*/mysqlx-bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# MySQL neu starten
sudo systemctl restart mysql

# Datenbank-Dump herunterladen
wget https://raw.githubusercontent.com/obamosaurus/Ticketsystem/main/osTicketDB_backup.sql

# Root-Passwort setzen und Remote-Zugriff konfigurieren
sudo mysql -e "
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Riethuesli>12345!';
  CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'Riethuesli>12345!';
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
  FLUSH PRIVILEGES;"

# Dump importieren
sudo mysql -u root -p'Riethuesli>12345!' < /home/ubuntu/osTicketDB_backup.sql

# Dump-Datei entfernen
sudo rm osTicketDB_backup.sql

# --- Ende der Remote-Befehle ---
EOF



### database-init.sh ### END
# ----------------------------------------
### apacheWebserver-init.sh ### START


# ssh verbindung webserver
ssh -o StrictHostKeyChecking=no \
    -i "$HOME/.ssh/osTicketGroupTFD_key.pem" \
    ubuntu@"$WEB_PUBLIC_IP" << 'EOF'

# --- Beginn der Remote-Befehle ---

# Benutzereingaben verhindern
export DEBIAN_FRONTEND=noninteractive

# needrestart: Services neustarten ohne Daemons-Popup
sudo sh -c 'echo "\$nrconf{restart} = '\''a'\'';" > /etc/needrestart/conf.d/99-restart-auto.conf'

# Update und Upgrade
sudo apt update && sudo apt upgrade -y

# Apache installieren und starten
sudo apt install -y apache2
sudo systemctl unmask apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Services für osTicket installieren
sudo apt install -y php-mysql
sudo apt install -y mysql-client
sudo apt install -y libapache2-mod-php
sudo systemctl restart apache2


### apacheWebserver-init.sh ### END
# ----------------------------------------
### osticket-init.sh ### START


# osTicket herunterladen und entpacken
wget https://raw.githubusercontent.com/obamosaurus/Ticketsystem/main/osTicket-v1.18.1.zip
wget https://raw.githubusercontent.com/obamosaurus/Ticketsystem/main/ost-config.php

sudo apt install -y unzip
unzip ~/osTicket-v1.18.1.zip -d /tmp/osTicket
sudo rm -rf /tmp/osTicket/osTicket-v1.18.1/scripts

# index.html entfernen
sudo rm -f /var/www/html/index.html

# osTicket in den Webserver verschieben
sudo mv /tmp/osTicket/osTicket-v1.18.1/upload/* /var/www/html/

# Besitzer und Dateiberechtigungen anpassen
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Temporäre Dateien löschen
rm -rf /tmp/osTicket
rm -f ~/osTicket-v1.18.1.zip
rm -f ~/osTicket-v1.18.1.zip:Zone.Identifier

# Config-File verschieben und Berechtigung setzen
sudo mv ost-config.php /var/www/html/include/ost-config.php
sudo chmod 0666 /var/www/html/include/ost-config.php

# --- Ende der Remote-Befehle ---
EOF



### osticket-init.sh ### END
# ----------------------------------------
### end ### START


clear

echo "Es kann sich nun auf das Ticketsystem verbunden werden."
echo "webServer Public IP: $WEB_PUBLIC_IP"
