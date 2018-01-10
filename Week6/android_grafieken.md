# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android StepCounter

* **hypothese:**  
Hoe kan ik informatie verschaffen aan google assistant met een lokale app?

* **testopzet:**  
Op [deze](https://developer.android.com/training/articles/assistant.html) gelinkte pagina staat een hele lijst met manieren om de google assistent aan te vullen. Ik wil minimaal de licht intensiteit laten weten aan google assistent zodat ik dit handsfree kan opvragen.

* **resultaat:** 
Dit heeft uiteindelijk tot niks geleid na veel te veel uren erin gestoken te hebben. Ik heb meerdere methodes geprobeerd:
1. De applicatie laten luisteren naar een intent van de assistant.
> Ik heb bovenstaande link gevolgd en gepoogd na te maken maar ik kon het niet voor elkaar krijgen dat ik andere data op het scherm kreeg dan een "gewone" websearch. 
2. De applicatie context mee laten geven over het active scherm. 
> Ik heb het hele process gedebugged voor het starten van de assistant door breakpoints in de activity class van android te plaatsen. Voor deze methode heb ik meerdere functies overschreven zodat ik de contextuele data aan kon leveren van mijn applicatie. Maar als ik dan vroeg aan google om mijn scherm te lezen gaf hij aan niks te kunnen vinden. 
3. Ook heb ik gekeken hoe ik een cloud oplossing hier voor kon maken. 
> Ik heb eerst gekeken of ik met [ifttt.com](http://ifttt.com) een link kon openen op het device die ik dan zou afvangen met de applicatie op de telefoon, dit zou kunnen werken met een aantal omwegen door meerdere apps te koppelen maar dit kan niet out of the box. Ook heb ik gepoogd om een cloud google action toe te voegen aan m'n assistant maar dit wilde ook niet lukken aangezien ik op de pagina waar ik de acties kan koppelen enzo. Een witte pagina voorgeschoteld krijg. 

Punt 3 lijkt LightSensorforAssistanthet meest resultaat op te leveren maar dan heb ik de hypothese niet beantwoord maar dan open ik een app met een custom voice comando. 