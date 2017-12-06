# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android StepCounter

* **hypothese:**  
Hoe kan er in android stappen worden geteld. 

* **testopzet:**  
Door een poc te maken waarmee live de stappen worden geteld.  
 
* **resultaat:**  
Om dit proof of concept te maken heb ik [deze](http://www.gadgetsaint.com/android/create-pedometer-step-counter-android/#.Wiamz7Q-fKI) tutorial gevolgd. 
Deze maakt zelf een stepcounter door de accelerometers uit te lezen. Hiervoor wordt de interface: StepListener aangemaakt en deze wordt dan weer geimplementeerd in de MainActivity. 
Ook wordt er in deze tutorial logica gemaakt voor het vertalen van beweging naar een gemeten stap. 

Toen ik deze tutorial vond heb ik nogal getwijfeld aan de manier hoe de stappen werden gemeten en geteld (het leek me sterk dat android dit niet standaard had).
Na wat extra research bleek dat hier inderdaad een [sensor](https://developer.android.com/reference/android/hardware/Sensor.html#TYPE_STEP_COUNTER) voor is die direct kan worden opgevraagd/uitgelezen.  


