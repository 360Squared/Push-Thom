# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg de code ook toe in de map **code**.
 
### Android youtube starter

* **hypothese:**  
Hoe kan er in een android app youtube gestart worden.

* **testopzet:**  
Door een poc te maken waarmee een youtube filmpje kan worden gestart. 
 
* **resultaat:**  
Ik wilde eerst een filmpje in een soort 'iframe' starten, dit heb ik eerst al gepoogd op ios (bleek niet of nauwelijks mogelijk). Als alternatief start ik nu de link in een nieuw scherm en als youtube dan als standaard app staat ingesteld wordt deze gestart.
Dit wordt bereikt door onderstaande code.

```java
startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com/watch?v=9bZkp7q19f0")));
```

Hiervoor heb ik een standaard android project gemaakt, hier een button aan toegevoegd en bovenstaande regel uitgevoerd wanneer er op de button wordt geklickt.