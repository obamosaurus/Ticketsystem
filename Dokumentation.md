# Dokumentation

# Inhaltsverzeichnis
1. [Projektbeschreibung](#1-projektbeschreibung)
2. [Auswahl des Ticketsystems](#1-auswahl-des-ticketsystems)
3. [Server Auswahl](#2-Server Auswahl)
4. [Scripts](#3-Scripts)
5. [Test](#4-test)
6. [Reflexion](#5-reflexion)

## 1. **Projektbeschreibung**
Das Ziel des Projekt ist, dass wir

## 2. **Auswahl des Ticketsystems**
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

## 3. **Server Auswahl**
Wir haben uns für folgende Server entschieden:
Webserver:  Apache
Datenbank:  MySQL

Wir haben uns für diese Server entschieden, da diese die üblichsten sind und wir damit bereits Erfahrungen gesammelt haben.

## 4. Scripts
Wir haben uns im Team entschieden mehrere kleine Scripts zu erstellen und nicht ein grosses Script. Bei den einzelnen Scripts geht es nur um die Installation der einzelnen Server und Diensten. Die Idee dahinter ist, das wir so immer zum gleichen Setup kommen und das keine Fehler während der Installation auftauchen.

Wir haben Apache auf WSL installiert als Test und haben geprüft ob der Dienst am laufen ist.
Der Dienst läuft. 

## 5. Test

## 6. Reflexion