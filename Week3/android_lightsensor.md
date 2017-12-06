# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android LightSensor

* **hypothese:**  
Hoe kan er in android licht worden gemeten. 

* **testopzet:**  
Door een poc te maken waarmee de licht intensiteit kan worden gemeten.  
 
* **resultaat:**  
Voor dit proof of concept heb ik alleen een standaard android project gemaakt en in de mainActivity een aantal dingen toegevoegd. 
In de onCreate heb ik een Sensorlistener geregistreerd met onderstaande code:
```java
SensorManager mySensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
Sensor LightSensor = mySensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
mySensorManager.registerListener(LightSensorListener, LightSensor, SensorManager.SENSOR_DELAY_NORMAL);
```
Deze roept dan onderstaande listener aan die de waarde van de lichtsensor op het scherm laat zien.
```java
private final SensorEventListener LightSensorListener = new SensorEventListener() {
    @Override
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.TYPE_LIGHT) {
            textLight.setText("light value: " + event.values[0]);
        }
    }
};
```

 