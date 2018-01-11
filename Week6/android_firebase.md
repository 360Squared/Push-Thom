# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android firebase

* **hypothese:**  
Hoe kan ik geauthenticeerd data schrijven/lezen naar/van firebase?

* **testopzet:**  
Ik wil hiervoor een demo app maken die inlogt met google authenticatie en daarna wat schrijft in de realtime database van firebase.

* **resultaat:** 
Het leek mij heel eenvoudig om in elkaar te zetten, het is tenslotte beide (een soort) van google. Maar dit bleek nog erg tegen te vallen. 
Vooral het authenticatie deel, hiervoor ben ik pas bij de tweede library succesvol geweest, ik heb het eerst op de "standaard" manier geprobeerd, zoals op de [firebase authenticatie](https://firebase.google.com/docs/auth/android/google-signin) staat.
Na nog wat zoeken ben ik erachter gekomen dat firebase zelf ook nog een andere library ([firebase ui](https://firebase.google.com/docs/auth/android/firebaseui)) heeft voor de authenticatie die nog 'simpeler' was.   

Hiervoor moest in android studio een sha1 key gegenereerd worden en deze moest dan weer in firebase gezet worden.
Onderstaande dependency moest toegevoegd worden aan de gradle build file:
```groovy
compile 'com.firebaseui:firebase-ui-auth:3.1.0'
```
Daarna kan met onderstaande code een login op/met firebase worden gedaan, deze code zorgt ervoor dat je door middel van oauth ingelogd wordt. Dus de eerste keer moet je je account aanklikken en daarna blijf je ingelogd ook als je de app weer sluit en opnieuw start.
```java
public void login() {
    List<AuthUI.IdpConfig> providers = Arrays.asList(
            new AuthUI.IdpConfig.Builder(AuthUI.GOOGLE_PROVIDER).build()
    );
    startActivityForResult(AuthUI.getInstance().createSignInIntentBuilder().setAvailableProviders(providers).build(), RC_SIGN_IN);
}

@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == RC_SIGN_IN) {
        IdpResponse response = IdpResponse.fromResultIntent(data);
        if (resultCode == RESULT_OK) {
            FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
            Log.d(TAG, "onActivityResult: " + user.getDisplayName()); // prints the user name
        } else {
            super.finish();
        }
    }
}
```

Met bovenstaande code is dan wel ingelogd maar hoe kan er iets in de firebase database opgeslagen worden?

Dat kan door eerst onderstaande dependencies toe te voegen in de build.gradle:
```groovy
compile 'com.google.firebase:firebase-core:11.8.0'
compile 'com.google.firebase:firebase-database:11.8.0'
```
Dit zorgt ervoor dat we de database kunnen aanroepen, en dat kan dan weer eenvoudig met onderstaande code. 
```java
FirebaseDatabase database = FirebaseDatabase.getInstance();
DatabaseReference myRef = database.getReference("test");
myRef.setValue("hello world");
myRef.push();
```

En dit totaal levert onderstaand resultaat in firebase:
![alt text](Screen%20Shot%202018-01-11%20at%2013.18.28.png)

