
Voor het creeren van een geofence is het ondrestaande stuk code 
```Java
Geofence geofence = new Geofence.Builder()
         .setRequestId("geofence id")
         .setCircularRegion(51.9867038/**latitude*/,5.9510748 /**longitude*/, 100 /**radius*/)
         .setExpirationDuration(3600000/**expiration duration in milliseconds*/)
         .setTransitionTypes(1/**transition type, 1 on enter 2 on exit*/)
         .build();
```