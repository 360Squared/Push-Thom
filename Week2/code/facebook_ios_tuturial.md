
## ios facebook login

----
Voor dit proof of concept gaan we de meest minimalistische vorm van een login met faceboek implementeren.
 
Dit gaan we doen door jezelf in en uit te kunnen loggen door de sso provider van facebook.
 
### Voorbereiding
 
Voor dit proof of concept moet er eerst een basis blanco ios project gemaakt worden, in mijn geval voor ios versie 11. 
In dit project gaan we delen van de facebook sdk toevoegen, [Hier te downloaden](https://origincache.facebook.com/developers/resources/?id=facebook-ios-sdk-current.zip). 

In het project maken we een nieuwe groep(folder) genaam 'frameworks' hierin zetten we de FBSDKLoginkit.framework en FBSDKCorekit.framework uit de gedownloade zip. 
Ook moet de uitgepakte versie van de zip aan de Framework Search Paths van de applicatie toegevoegd worden.

In de info.plist moet binnen de <dict> </dict> tags onderstaande geplaatst worden.

```xml

<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb app id</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>fb app id</string>
<key>FacebookDisplayName</key>
<string>Square cloud test</string>
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>
``` 
Voor deze app gaan we eerst een eenvoudige front-end creeeren, zie onderstaande afbeelding.

![alt text](Screen%20Shot%202017-11-30%20at%2010.37.19.png)

Hier maken we dus een button en een imageView (voor later).  
Je kunt de button ook van de classe FBSDKLoginButton maken, dan wordt die gelijk naar de facebook style gemaakt en wordt de standaard login actie toegepast(leuk om een keertje te proberen) maar wij willen meer.
 
----
Nu gaan we echt de code in duiken.

Wij gaan zelf de actie achter de button in elkaar zetten, dus het inloggen bij facebook de status van de button bijhouden en de tekst op de button aanpassen. 
Hiervoor gaan onderstaande code toevoegen aan de ViewController. 

```swift
    //when login button clicked
    @IBAction func loginButtonClicked(_ sender: FBSDKLoginButton) {
        let loginManager = FBSDKLoginManager()
        
        if self.isLoggedIn {
            if self.profileImage != nil && self.profileImage.image != nil {
                self.profileImage.image = nil
            }
            self.isLoggedIn = false
            self.facebookButton.setTitle("Log in met Facebook", for: .normal)
            loginManager.logOut()
        } else {
            loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self, handler: { (result, error)-> Void in
                if (error != nil)
                {
                    print("error is \(String(describing: error))")
                }
                if (!(result?.isCancelled)! && (result?.grantedPermissions.contains("email"))!)
                {
                    self.getFBUserData();
                    self.facebookButton.setTitle("Log uit", for: .normal)
                    self.isLoggedIn = true
                }
            })
        }
    }
``` 
Deze functie handelt de actie van de button af waarbij de basis login actie eigenlijk nagebootst wordt. 

Om nog meer data van de facebook gebruiker op te halen is de functie getFBUserData. Deze functie staat hieronder beschreven. 

```swift
func getFBUserData(){
    if((FBSDKAccessToken.current()) != nil) {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender , age_range, timezone"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                
                self.dict = result as! [String : AnyObject]
                if let picture = self.dict["picture"] as? [String: Any] {
                    
                    if let pictureData = picture["data"] as? [String: Any] {
                        if let pictureUrlString = pictureData["url"] as? String {
                            
                            let pictureUrl = URL(string: pictureUrlString)
                            self.imageUrl = pictureUrl
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                let contentsOfURL = try? Data(contentsOf: pictureUrl!)
                                
                                DispatchQueue.main.async {
                                    if pictureUrl == self.imageUrl {
                                        if let imageData = contentsOfURL {
                                            self.profileImage?.image = UIImage(data: imageData)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
    }
}
``` 

Deze functie zorgt ervoor dat de facebook profiel foto in de applicatie zichtbaar wordt gemaakt.
Dit zijn de meest basis functies die dit concept bewijzen daarnaast moet de app worden goedgekeurd als er meer data van facebook gehaald wordt. 
Dingen die bijvoorbeeld niet opgehaald kunnen worden als de app niet is goedgekeurd: link, location, work, birthday, relationship_status, interested_in, about, education.
 
