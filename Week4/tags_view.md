# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### ios tags view

* **hypothese:**  
Er kwam vanuit de groep een vraag naar een tag systeem zodat wij daar vaardigheden/interresses konden tonen.

* **testopzet:**  
Ik heb een voorbeeld gezocht dat de tags als blauwe blokjes toonde. Dit wilde ik dan aanpassen zodat de geselecteerde items uit de [fancy list](fancy_list.md) hierin getoond zouden worden. 

* **resultaat:**  
Om dit te realiseren heb ik de applicatie uit [fancy list](fancy_list.md) uitgebreid. 
Doordat ik al een projectje had met een lijst heb ik een nieuwe viewcontroller aangemaakt en heb ik [dit voorbeeld project](https://github.com/whitesmith/WSTagsField) gebruikt door gewoon de classen die ik nodig had erin te slepen. 
Ik heb ook gekeken hoe zei dit in de layout hadden gezet en dit nagebouwd in mijn applicatie. 
De volgende stap was de data van mijn fancy list in de het tags veldje krijgen. 
Hiervoor heb ik in de ViewController een extra lijst gemaakt (skills), daar heb ik een setter actie op gezet die per ding wat in die lijst gezet wordt een tag aanmaakt. 
```swift
var skills:[Skill] {
    get {
        ...
    }
    set(skillList) {
        tagsField.removeTags()
        tagsField.readOnly = true
        for item in skillList {
            tagsField.addTag(item.name)
        }
    }
}
```
Door de ViewController mee te sturen naar de fancy list kan ik bovenstaande lijst vullen en dus tonen op het scherm. 
Zie onderstaand voorbeeld:
![Tags](Screen%20Shot%202017-12-22%20at%2011.17.42.png)
