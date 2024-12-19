# Dokumentation

# Inhaltsverzeichnis
1. [Auswahl des Ticketsystems](#1-auswahl-des-ticketsystems)
2. [Datenbank](#2-datenbank)
3. [Webserver](#3-webserver)
4. [Test](#4-test)
5. [Reflexion](#5-reflexion)

## 1. **Auswahl des Ticketsystems**
Wir haben uns für osTicket entschieden.
Dann haben wir das File heruntergeladen und als ZIP Datei ins Github gepusht.
Daraufhin haben wir auch ein osticket-init.sh file erstellt. Dort befindet sich die Befehle um
osTicket zu installieren. Die Datei wird in AWS unzippt und in den gewünschten Ordner geschoben,
der durch Apache installiert werden soll. Zum schluss haben wir den Owner geändert

--Stichwörter für Text
osticket mit zip datri installiert
mit unzip in aws entzippen
mit mv in den gewüschten ordner scheiben, der durch apache installiert werden sollte
mit chown wird der Besitzer gewechselt

## 2. Datenbank
Als Datenbank haben wir mysql gewählt. Zuerst installieren wir mysql und starten den Server.
## 3. Webserver
Wir haben Apache auf WSL installiert als Test und haben geprüft ob der Dienst am laufen ist.
Der Dienst läuft. 

## 4. Test

## 5. Reflexion