# Dokumentation

## Inhaltsverzeichnis
1. [Projektbeschreibung](#1-projektbeschreibung)
2. [Auswahl des Ticketsystems](#2-auswahl-des-ticketsystems)
3. [Server Auswahl](#3-server-auswahl)
4. [Scripts](#4-scripts)
5. [Vorgehen](#5-vorgehen)
6. [Testfälle](#6-testfälle)
7. [Reflexion](#7-reflexion)
8. [Quellenverzeichnis](#8-quellenverzeichnis)

<br>

## 1. Projektbeschreibung
**Aufgabenstellung:**
- **Ausgangslage:**
  Die Fertigkeiten im praktischen Umgang mit der Cloud demonstrieren. Dies soll in einer selbstgewählten Dreiergruppe durchgeführt werden.
  
- **Ziele:**
  1. Ein Service soll in der Cloud funktionstüchtig aufgesetzt werden.
  2. Der Service soll als IaC (Infrastructure as Code) strukturiert sein. Die Konfigurationsdateien werden mit einer Versionsverwaltung verwaltet.
  3. Die Dokumentation wird in Git via Markdown erstellt.
  4. Einzelne Testfälle sollen durchgespielt, mit Screenshots dokumentiert und in der Dokumentation abgelegt werden.
  
- **Aufgabenstellung:**
  Installation eines Ticketsystems unserer Wahl.


<br><br>

## 2. Auswahl des Ticketsystems
Wir haben uns für **osTicket** entschieden.

- **Vorgehensweise:**
  1. Das osTicket-Archiv wurde heruntergeladen und als ZIP-Datei in GitHub hochgeladen.
  2. Ein `osticket-init.sh`-Skript wurde erstellt, das die folgenden Befehle enthält:
      - Entpacken des osTicket-Archivs in AWS mittels `unzip`.
      - Verschieben der entpackten Dateien in das gewünschte Verzeichnis, das von Apache bedient wird, mittels `mv`.
      - Ändern des Besitzers des Verzeichnisses mittels `chown`.
  
- **Stichwörter für den Text:**
  - osTicket mit ZIP-Datei installiert
  - Mit `unzip` in AWS entpacken
  - Mit `mv` in den gewünschten Ordner verschieben, der von Apache installiert werden soll
  - Mit `chown` den Besitzer wechseln

<br><br>

## 3. Server Auswahl
Wir haben uns für folgende Server entschieden:
- **Webserver:** Apache
- **Datenbank:** MySQL

**Begründung:**
Diese Server sind die gängigsten und wir haben bereits Erfahrung im Umgang mit ihnen gesammelt.

<br><br>

## 4. Scripts
Im Team haben wir uns entschieden, mehrere kleine Skripte zu erstellen, anstatt ein großes Skript. Jedes Skript ist für die Installation eines einzelnen Servers oder Dienstes zuständig. 

**Vorteile:**
- Konsistentes Setup bei jeder Installation
- Minimierung von Fehlern während der Installation

**Ablauf der Skripte:**
1. System auf den neuesten Stand bringen.
2. Installation des jeweiligen Dienstes mittels spezifischer Befehle.

<br><br>

## 5. Vorgehen
1. **Erstellung der Init-Skripte:**
   - Für jeden Server und Dienst wurde eine `init.sh`-Datei erstellt.
   
2. **Lokale Installation:**
   - Die Skripte wurden lokal ausgeführt, um die Dienste zu installieren.
   - Fehler wurden direkt im Skript behoben.

3. **Dokumentation:**
   - Ein `README` wurde erstellt, das die Anwendung und Funktion der Skripte beschreibt.
   - Die Dokumentation wird fortlaufend aktualisiert, um stets aktuell zu bleiben.

<br><br>

## 6. Testfälle

### Testfall 1: Datenbank Testen
**Durchgeführt von:** Tom Thach / Daris Bischof  
**Datum:** 22.12.2024, 18:00

**Durchführung:**
1. Ein neues Ticket auf dem osTicket-Webserver erstellt.
2. Überprüfung im Agenten-Account, ob das Ticket korrekt angezeigt wird.

**Screenshots:**
<br><br>

*Ticket erstellen rechts oben*
![Screenshot 1](https://github.com/user-attachments/assets/545bd1fd-3d1c-4393-92fe-1c679fbdd2cf)
<br><br>
*Ausgefülltes und erstelltes Ticket.*
![Screenshot 2](https://github.com/user-attachments/assets/cafd47d5-4cff-4779-b6b5-a9f93f5b29ca)  
<br>
*Überprüfung im Agenten-Account.*
![Screenshot 2024-12-22 174218](https://github.com/user-attachments/assets/01eae495-38c7-4d22-9bf7-942b06711142)


**Fazit:**
- Zugriff auf den Apache-Webserver mit installiertem osTicket erfolgreich.
- Erstellung eines Tickets bestätigt die erfolgreiche Verbindung zur Datenbank und korrekte Einrichtung.

<br><br>

### Testfall 2: Installation von Instances, VPC und Subnetz
**Durchgeführt von:** Tom Thach / Daris Bischof  
**Datum:** 22.12.2024, 18:00

**Durchführung:**
1. Nach Fertigstellung des `cloud-init.sh`-Skripts wurden die EC2-Instances in AWS überprüft.

**Screenshots:**
![Instances](https://github.com/user-attachments/assets/a80d40b8-f5e1-4a5a-b325-6422c90c80aa)
*Überprüfung der EC2-Instances.*

2. Überprüfung der Erstellung des "AutoVPC".

![VPC](https://github.com/user-attachments/assets/e413351a-9e5b-4164-85f7-da2f153b317d)
*Erstellung des AutoVPC.*

3. Überprüfung des eigenen "AutoSubnet".

![Subnetz](https://github.com/user-attachments/assets/8357cd34-927c-4bee-9530-76b71e36fd33)
*Erstellung des AutoSubnet.*

**Fazit:**
- Alle benötigten Ressourcen (Instances, VPC, Subnetz) wurden erfolgreich erstellt.

---

## 7. Reflexion
**Flavio:**   
*Ich habe während dem Projekt zu jeder Zeit eine gute Kommunikation erlebt. Wir haben meiner Meinung nach in der Gruppe sehr gut funktioniert. Wir haben in der Gruppe die Arbeiten gut aufgeteilt, so dass jeder zu seinen stärken etwas beitragen kann.*   

*Wir hatten das Zeitmanagement eigenlich immer gut im griff ausser gegen den Schluss mussten wir etwas stressen. Das beste am Projekt war als das Skript dann funktioniert hatte. Am wenigsten gefallen hat mir das erstellen der Skripts, dazu hatten wir anfangs ein paar Schwierigkeiten mit dem starten, da wir nicht genau wussten was wir machen müssen.*

 <br>

**Tom:**   
**Was lief gut?**      
*Das Projekt war ein Erfolg für mich. Wir haben gemeinsam die AWS-Instanzen konfiguriert und das Skript verbessert. Es hat Spass gemacht, zu sehen, wie unsere Arbeit am Ende funktioniert hat. Besonders gefallen hat mir die Zusammenarbeit mit Daris, weil wir in den letzten Tagen des Projekts immer sehr lange dran und wach geblieben sind bis es endlich funktioniert hatte.*

**Herausforderungen**     
*Am Anfang war ich unsicher, weil ich nicht genau wusste, was zu tun war. In den Lektionen hatten wir nur grundlegende Dinge wie eine Instanz und ein Bucket erstellt, und mir fehlte das Wissen über die Sachen die wir nicht hatten wie GitLab oder GitHub. Das hat mich anfangs etwas verwirrt und verunsichert.*

**Lernerfolge**      
*Ich habe während des Projekts viel gelernt über Github und AWS. Fehler finden in den Skripts und diese auch beheben hatte mir Spass gemacht und so konnte ich mehr über die Scripts lernen wie alles genau funktioniert. Das Instanzen Skript war für mich ein Erfolg, weil Daris und ich eine weile lang daran gearbeitet haben und es endlich funktioniert hatte ohne Fehlerausgabe oder eine Eingabe des Benutzers.*

**Rückblick und Verbesserungsvorschläge**      
*Was mir nicht so gefallen hat, war, dass ich zunächst nur an der Dokumentation gearbeitet habe, obwohl ich auch praktisch tätig sein wollte. In zukünftigen Projekten möchte ich aktiver von Anfang an mitarbeiten. Ich finde man sollte in den Lektionen erklären was Github/Gitlab ist und auch wie es funktioniert. Dasselbe sollte man auch machen wie sich die Instanzen sozusagen verbinden können, weil die zuerst sich gar nicht verbinden konnte ohne eigene VPC und Subnetz.*

<br>

**Daris:**   
*Am Anfang war die Arbeit an den Scripten recht überschaubar. Es hat mir insgesamt Spass gemacht, auch wenn ich manchmal die Nerven verlierte beim Debugging, und wir konnten uns bei den bash Commands gut gegenseitig helfen.*

*Gegen Ende wurde es viel komplizierter, vor allem beim Zusammenfügen der kleinen Scripts zum *cloud-init.sh*. Anfangs hat es nicht funktioniert, im Script via SSH, Befehle auszuführen. Auch das Erstellen von VPC und Subnetzmasken über die CLI war schwierig, weil uns das im Unterricht nicht gezeigt wurde und es nicht im GBS GitLab stand. Ich hätte mir gewünscht, das im Unterricht genauer anzusehen. Durch Recherche haben wir es aber hinbekommen.* 

*Das arbeiten an der Doku ging völlig klar, hat mir jedoch nicht besonders viel Spass gemacht.*   
*Ich bin froh dass ich zwei kompetente Teampartner hatte welche beide auch ihren Beitrag zum Projekt geleistet haben.*

*Ich hatte zum Glück schon etwas Erfahrung mit Git, da ich schon öfters Zusammenfassungen ins GitHub-Wiki geschrieben habe. Trotzdem wäre eine Einführung ins GitHub/GitLab sinnvoll gewesen, damit alle auf dem gleichen Stand wären.*    
*Gegen das Ende haben wir drei uns aber recht gut damit zurechtgefunden.*

<br>

---


## 8. Quellenverzeichnis
| Was                                           | Quelle                                                                                     | Datum        |
|-----------------------------------------------|--------------------------------------------------------------------------------------------|--------------|
| GBS Anleitung AWS                             | OneNote M364: Bash Script Befehle                                                          | 12.12.2024   |
| GBS Anleitung AWS                             | 09-AA-EC2-Instance-CLI.pdf (Aufgabenblatt von Lektion 28.11.2024)                        | 12.12.2024   |
| GBS GitLab M346                               | [GBS GitLab M346](https://gbssg.gitlab.io/m346/iac-aws-cli/)                              | 17.12.2024   |
| VPC und Subnetz erstellen                     | [ChatGPT Share](https://chatgpt.com/share/67686072-4fb8-800a-9e1a-e807f45fbd2d)           | 21.12.2024   |
| Remotezugriff von Webserver zu DB erlauben     | [Linuxize - MySQL Remote Access](https://linuxize.com/post/mysql-remote-access/)          | 22.12.2024   |

---
