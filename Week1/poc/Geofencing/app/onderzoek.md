
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

### Geofences maken

Voor het creeren van een geofence is het ondrestaande stuk code. 
```java
Geofence geofence = new Geofence.Builder()
         .setRequestId("geofence id")
         .setCircularRegion(51.9867038/*latitude*/,5.9510748 /*longitude*/, 100 /*radius*/)
         .setExpirationDuration(3600000/*expiration duration in milliseconds*/)
         .setTransitionTypes(1/*transition type, 1 on enter 2 on exit*/)
         .build();
```

Het geofence van hierboven kan dan gekoppeld worden aan de geofence monitor. Door de code hieronder, naast het toevoegen van een enkele geofence kan er met de addGeofences() een lijst van geofences in een keer worden toegevoegd.

```java
        // init the geofence request builder.
        GeofencingRequest.Builder builder = new GeofencingRequest.Builder();
        builder.setInitialTrigger(GeofencingRequest.INITIAL_TRIGGER_ENTER);

        builder.addGeofence(geofence); //Add the geofence to be monitored by geofencing service.

        builder.build(); // Build the request.
```
----
### Intents

Nu is er dus een geofence aangemaakt en wordt die ook actief gemonitored. 
Maar als er in of uit de geofence wordt bewogen wordt is dit voor niemand zichtbaar. 
Wij gaan er voor zorgen dat er een simpele melding wordt getoond zodra er een geofence betreden of uittreden wordt.

Hiervoor is er een classe gemaakt die de IntentService extends. 
In deze service overschrijven we de onHandleIntent functie zodat wij onze eigen actie aan de getriggerde intent kunnen koppelen.
In dit poc is er uitgegaan van de happy flow. Voor een productie versie moeten er extra checks worden gedaan op errors oid.
```java
@Override
protected void onHandleIntent(Intent intent) {
    Log.d(TAG, "onHandleIntent: transition");
    GeofencingEvent geofencingEvent = GeofencingEvent.fromIntent(intent);
    int geofenceTransition = geofencingEvent.getGeofenceTransition();
    if (geofenceTransition == Geofence.GEOFENCE_TRANSITION_ENTER || geofenceTransition == Geofence.GEOFENCE_TRANSITION_EXIT || geofenceTransition == Geofence.GEOFENCE_TRANSITION_DWELL) {
        List<Geofence> triggeringGeofences = geofencingEvent.getTriggeringGeofences();
        String geofenceTransitionDetails = getGeofenceTransitionDetails(geofenceTransition, triggeringGeofences);
        sendNotification(geofenceTransitionDetails);
    }
}
```

In dit geval is er voor de berichtgeving een Toast en notificatie gemaakt, door onderstaande code.
```java
private void sendNotification(final String notificationDetails) {
    new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
            Toast.makeText(getApplicationContext(), notificationDetails, Toast.LENGTH_LONG).show();
            NotificationCompat.Builder mBuilder =
                    new NotificationCompat.Builder(getApplicationContext())
                            .setSmallIcon(R.drawable.common_google_signin_btn_icon_dark)
                            .setContentTitle("Geofence")
                            .setContentText(notificationDetails);
            ((NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE)).notify(001, mBuilder.build());
        }
    });
}
```

Hier was/is een extra actie voor nodig omdat dit proces in een andere thread draait (degene die door de intentService wordt gecreerd).

