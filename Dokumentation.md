# Dokumentation

# Inhaltsverzeichnis
1. [Projektbeschreibung](#1-projektbeschreibung)
2. [Auswahl des Ticketsystems](#1-auswahl-des-ticketsystems)
3. [Server Auswahl](#3-server-auswahl)
4. [Scripts](#3-Scripts)
5. [Vorgehen](#4-Vorgehen)
6. [Testfälle](#5-Testfälle)
7. [Reflexion](#7-reflexion)

## 1. **Projektbeschreibung**
Das Aufgabenstellung ist folgende:
*Ausgangslage:*
Die Fertigkeiten mit der Cloud prakitsch zeigen. Das Ganze können wir in einer selbstgewählten Dreiergruppe erledigen.
*Ziele:*
Es wurden vier Haupt ziele gesetzt. 1. Ein Service soll in der Cloud funktiontüchtig aufgesetzt werden. 2. Der Service soll als IaC (Infrastructure as Code) geestaltet sein. Die Konfigurationsdateien werden mit einer Versionsverwaltung verwaltet. 3. Die Dokumentation wir in Git via Markdown geschrieben. 4. Einzelne Testfälle sollen durchgespielt werden und mit Screenshots dokumentiert werden und in der Dokumnetation abgelegt werden.
*Aufgabenstellung:* 
Wir müssen ein Ticketsystem unserer Wahl installieren.

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
Wir haben uns im Team entschieden mehrere kleine Scripts zu erstellen und nicht ein grosses Script. Bei den einzelnen Scripts geht es nur um die Installation der einzelnen Server und Diensten. Die Idee dahinter ist, das wir so immer zum gleichen Setup kommen und das keine Fehler während der Installation auftauchen. In diesen Scripts ist immer in etwa der gleich Ablauf. Zuerst wird das System auf den neusten Stand gebracht und dann kommt der Befehl der den gewissen Dienst installiert. 


## 5. Vorgehen
Wir haben für jegliche Server und Dienste eine Init.sh Datei erstellt. Dazu haben wir zuerst die Scripts erstellt und mithilfe der erstellten Scripts die Dienste Lokal installiert. Wenn etwas da schon nicht geklappt hat haben wir es direkt im Script behoben. 
Anfangs haben wir direkt noch das README erstellt. Dort werden wir genauer beaschreiben, wie die Scripts anzuwenden sind und was diese genau machen.
Die Dokumenatation führen wir immer fortlaufend, das wir die Dokumentation immer Up-To-Date halten können.

## 6. Testfälle

Datenbank Testen: Tom Thach / Daris Bischof 22.12.2024 18:00

Wir haben auf osTicket ein neues Ticket erstellt auf dem WebServer.

![Screenshot 2024-12-22 173537](https://github.com/user-attachments/assets/545bd1fd-3d1c-4393-92fe-1c679fbdd2cf)
---
<br>
Hier sieht man das ausgefüllte Ticket und es wurde erstellt.

![Screenshot 2024-12-22 173901](https://github.com/user-attachments/assets/cafd47d5-4cff-4779-b6b5-a9f93f5b29ca)
![Screenshot 2024-12-22 174205](https://github.com/user-attachments/assets/69a2bf00-4947-41e0-9b49-16484b40850e)
---
<br>
Nachdem wir es erstellt haben, sind wir auf den Agent Account und haben darin geschaut ob das Ticket wirklich drin ist.

![Screenshot 2024-12-22 174218](https://github.com/user-attachments/assets/a2122c25-6bfb-4428-930a-cedb660d031a)
![Screenshot 2024-12-22 174241](https://github.com/user-attachments/assets/89ca7697-0d63-4c53-85c7-cd88ff0de6e1)
---



In den Tickets steht das neue Ticket. Bedeutet es hat funktioniert.
Wir können es auch schliessen, eine Antwort darauf geben.

---

Fazit: <br>
Es konnte auf den Apache WebServer zugegriffen werden mit osTicket drauf. 
Wenn man ein Ticket erstellen bedetuet das eine Verbindung zu der Datenbank erfolgreich ist und die Datenbank korrekt angelegt wurde.


## 7. Reflexion
Flavio:


Tom:

Daris:
