
## Android geofencing

----
Voor dit proof of concept gaan we de meest minimalistische vorm van geofencing toepassen. 
Dit gaat gedaan worden door een klein geofence te maken en hier een toast aan te hangen als deze betreden wordt.

### Voorbereiding
Omdat voor dit proof of concept toegang nodig is voor de locatie moeten er permissies worden gevraagd aan android.
De aanpassingen die hiervoor moeten de volgende aanpassingen in het manifest.xml gedaan worden: 
- Permissie toevoegen
- Service toevoegen
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.thom.geofencing">
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <application>
        <service android:name=".GeofenceTransitionsIntentService"/>
        ...
    </application>
</manifest>

```

Om uiteindelijk de geofencing Classes en Interfaces te kunnen benaderen moeten de onderstaande toevoegingen aan de build.gradle worden gedaan.

```json
apply plugin: 'com.android.application'

...

dependencies {
    compile 'com.google.android.gms:play-services-location:11.0.0'
    ...
}

```
----

###Geofences maken

Voor het creeren van een geofence is het ondrestaande stuk code 
```Java
Geofence geofence = new Geofence.Builder()
         .setRequestId("geofence id")
         .setCircularRegion(51.9867038/**latitude*/,5.9510748 /**longitude*/, 100 /**radius*/)
         .setExpirationDuration(3600000/**expiration duration in milliseconds*/)
         .setTransitionTypes(1/**transition type, 1 on enter 2 on exit*/)
         .build();
```