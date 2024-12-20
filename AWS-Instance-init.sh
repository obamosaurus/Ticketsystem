#!/bin/bash
 
# SSH-Key erstellen
echo "Erstelle SSH-Key..."
mkdir -p ~/.ssh && aws ec2 create-key-pair --key-name osTicketGroupTFD_key --key-type rsa --query 'KeyMaterial' --output text > ~/.ssh/osTicketGroupTFD_key.pem && chmod 600 ~/.ssh/osTicketGroupTFD_key.pem
echo "SSH-Key erstellt und gespeichert unter ~/.ssh/osTicketGroupTFD_key.pem"
 
# Key-Pfad setzen
KEY_PATH="$HOME/.ssh/osTicketGroupTFD_key.pem"
 
# Sicherheitsgruppe erstellen
echo "Erstelle Security Group..."
GROUP_ID=$(aws ec2 create-security-group --group-name osTicketGroupTFD_secGroup --description "EC2-M364 sec-group" --query 'GroupId' --output text)
echo "Security Group erstellt. Group ID: $GROUP_ID"
 
# Sicherheitsregeln setzen
echo "Autorisiere Sicherheitsregeln für Port 80 (HTTP)..."
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
echo "Port 80 (HTTP) autorisiert."
 
echo "Autorisiere Sicherheitsregeln für Port 22 (SSH)..."
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
echo "Port 22 (SSH) autorisiert."
 
# EC2-Instanz dbServer starten 
echo "Starte EC2-Instanz..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id ami-08c40ec9ead489470 \
    --count 1 \
    --instance-type t2.micro \
    --key-name osTicketGroupTFD_key \
    --security-group-ids $GROUP_ID \
    --iam-instance-profile Name=LabInstanceProfile \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=dbServer}]' \
    --query 'Instances[0].InstanceId' --output text)
 
echo "EC2-Instanz gestartet. Instance ID: $INSTANCE_ID"


# EC2-Instanz webServer starten 
echo "Starte EC2-Instanz..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id ami-08c40ec9ead489470 \
    --count 1 \
    --instance-type t2.micro \
    --key-name osTicketGroupTFD_key \
    --security-group-ids $GROUP_ID \
    --iam-instance-profile Name=LabInstanceProfile \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=webServer}]' \
    --query 'Instances[0].InstanceId' --output text)
 
echo "EC2-Instanz gestartet. Instance ID: $INSTANCE_ID"
