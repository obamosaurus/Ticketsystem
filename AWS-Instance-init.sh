#!/bin/bash

#
# TEIL 1: VPC, Subnetz und Internet-Gateway erstellen
#

# 1) VPC erstellen
echo "Erstelle VPC..."
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --query 'Vpc.VpcId' \
  --output text)
echo "VPC erstellt. VPC ID: $VPC_ID"

# 2) Warten, bis die VPC verfuegbar ist
echo "Warte auf die VPC-Verfuegbarkeit..."
aws ec2 wait vpc-available --vpc-ids $VPC_ID

# 3) Tag der VPC setzen
aws ec2 create-tags \
  --resources $VPC_ID \
  --tags Key=Name,Value=AutoVPC
echo "VPC getaggt als 'AutoVPC'."

# 4) Subnetz erstellen
echo "Erstelle Subnetz..."
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block 10.0.1.0/24 \
  --query 'Subnet.SubnetId' \
  --output text)
echo "Subnetz erstellt. Subnet ID: $SUBNET_ID"

# 5) Warten, bis das Subnetz verfuegbar ist
echo "Warte auf die Subnetz-Verfuegbarkeit..."
aws ec2 wait subnet-available --subnet-ids $SUBNET_ID

# 6) Tag des Subnetzes setzen
aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags Key=Name,Value=AutoSubnet
echo "Subnetz getaggt als 'AutoSubnet'."

# 7) Internet-Gateway erstellen und an VPC anhaengen
echo "Erstelle Internet-Gateway..."
IGW_ID=$(aws ec2 create-internet-gateway \
  --query 'InternetGateway.InternetGatewayId' \
  --output text)
echo "Internet-Gateway erstellt. IGW ID: $IGW_ID"

aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID
echo "Internet-Gateway an die VPC angehaengt."

# 8) Routing-Tabelle erstellen und Route zu 0.0.0.0/0 hinzufuegen
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

# 9) Subnetz mit Routing-Tabelle verknuepfen
aws ec2 associate-route-table \
  --subnet-id $SUBNET_ID \
  --route-table-id $ROUTE_TABLE_ID
echo "Subnetz mit der Routing-Tabelle verknuepft."

echo "VPC und Subnetz wurden erfolgreich erstellt."
echo "VPC ID: $VPC_ID"
echo "Subnetz ID: $SUBNET_ID"


#
# TEIL 2: SSH-Key, Security Group und EC2-Instanzen erstellen
#

# 1) SSH-Key erstellen
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
#    Hinweis: --vpc-id sorgt dafuer, dass die Gruppe in der neu erstellten VPC liegt.
echo "Erstelle Security Group..."
GROUP_ID=$(aws ec2 create-security-group \
  --group-name osTicketGroupTFD_secGroup \
  --description "EC2-M364 sec-group" \
  --vpc-id $VPC_ID \
  --query 'GroupId' \
  --output text)
echo "Security Group erstellt. Group ID: $GROUP_ID"

# 3) Sicherheitsregeln setzen
#    a) TCP 80 (HTTP)
echo "Autorisiere Sicherheitsregeln fuer Port 80 (HTTP)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0
echo "Port 80 (HTTP) autorisiert."

#    b) TCP 22 (SSH)
echo "Autorisiere Sicherheitsregeln fuer Port 22 (SSH)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
echo "Port 22 (SSH) autorisiert."

#    c) TCP 3306 (MySQL) innerhalb der VPC
#       Damit sich Webserver und DB-Server gegenseitig erreichen koennen.
echo "Autorisiere Sicherheitsregeln fuer Port 3306 (MySQL)..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol tcp \
  --port 3306 \
  --cidr 10.0.0.0/16
echo "Port 3306 (MySQL) autorisiert."

#    d) ICMP (Ping) innerhalb der VPC
echo "Autorisiere ICMP (Ping) innerhalb der VPC..."
aws ec2 authorize-security-group-ingress \
  --group-id $GROUP_ID \
  --protocol icmp \
  --port -1 \
  --cidr 10.0.0.0/16
echo "ICMP (Ping) autorisiert."

# 4) EC2-Instanzen erstellen
#    Fuer beide Instanzen das gleiche AMI und Instance-Profil, jedoch unterschiedliche Tags (dbServer, webServer).
#    Subnetz wird auf die zuvor erstellte Subnet-ID gesetzt.

AMI_ID="ami-08c40ec9ead489470"   # Beispiel-AMI
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


ssh -o StrictHostKeyChecking=no \
    -i "$HOME/.ssh/osTicketGroupTFD_key.pem" \
    ubuntu@"$DB_PUBLIC_IP"
