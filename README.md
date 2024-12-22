
# Ticketsystem

Ein IAC Projekt mit welchem das Ticketsystem osTicket automatisiert auf der AWS-Infrastruktur erstellt wird.   
Dabei wird ein Apache-Webserver und eine MySQL Datenbank ohne erforderliche Benutzereingaben angelegt.
<br><br>

## Voraussetzungen

Bevor Sie mit der Installation beginnen, stellen Sie bitte sicher, dass die folgenden Voraussetzungen erfüllt sind:

1. **Betriebssystem:**
   - Windows Subsystem for Linux (WSL) mit Ubuntu
   - Ubuntu Linux

2. **AWS CLI:**
   - Stellen Sie sicher, dass die AWS CLI korrekt installiert und konfiguriert ist.
   - Folgen Sie der Anleitung der GBS [hier](https://gbssg.gitlab.io/m346/iac-aws-cli/).

3. **AWS Credentials:**
   - Gehen Sie ins **AWS Academy Learner Lab**.
   - Navigieren Sie zu **AWS Details > AWS CLI: Show**.
   - Kopieren Sie die angezeigten Credentials und fügen Sie diese in die Datei `~/.aws/credentials` im CLI ein.


   Die Datei sollte in etwa so aussehen:

   ```ini
   [default]
   aws_access_key_id = YOUR_ACCESS_KEY_ID
   aws_secret_access_key = YOUR_SECRET_ACCESS_KEY

<br><br>

## Installation

Wenn alle Voraussetzungen erfüllt sind, können Sie das cloud-init.sh mit curl ausführen. Öffnen Sie dazu WSL und geben Sie den folgenden Befehl ein:

```bash
curl -s https://raw.githubusercontent.com/obamosaurus/Ticketsystem/main/cloud-init.sh | bash
```

Dieser Befehl lädt das `cloud-init.sh`-Skript herunter und führt es automatisch aus. Sie müssen während des Prozesses nichts weiter tun.

<br><br>

## Abschluss der Installation

Nach erfolgreicher Ausführung des Skripts wird die öffentliche IP-Adresse des Webservers angezeigt. Diese IP-Adresse kann verwendet werden, um auf das Ticketsystem zuzugreifen.

Beispielausgabe:

```
Es kann sich nun auf das Ticketsystem verbunden werden.
webServer Public IP: XX.XX.XX.XX
```


Nun sollte der Zugriff auf osTicket möglich sein.
