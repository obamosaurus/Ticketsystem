# Dokumentation

# Inhaltsverzeichnis
1. [Inbetriebnahme](#inbetriebnahme)
2. [Verwaltung Konfigurationsdateien](#verwaltung-konfigurationsdateien) 
3. [Erfüllungsgrad](#3-erfüllungsgrad)
4. [Auswahl des Ticketsystems](#4-auswahl-des-ticketsystems)

## 1. Inbetriebnahme
Der Service muss einfach in einer Cloud in Betrieb genommen werden können (readme).

## 2. Verwaltung Konfigurationsdateien
Die Konfigurationsdateien sind in einer Versionsverwaltung nachvollziehbar abgelegt.

## 3. Erfüllungsgrad

## 4. **Auswahl des Ticketsystems**
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

## 5. Datenbank

## 6. Webserver