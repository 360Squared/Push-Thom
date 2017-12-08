# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android StepCounter

* **hypothese:**  
Hoe kan er een api call gedaan worden met authorisatie. 

* **testopzet:**  
Door een poc te maken waarmee ik data van [gdax.com](gdax.com) te halen.
 
* **resultaat:**  
Om dit te bereiken heb ik een poc in python gemaakt waarbij vooral onderstaande code voor de authorisatie belangrijk was. 
```python
        timestamp = str(time.time())
        message = timestamp + request.method + request.path_url + (request.body or '')
        hmac_key = base64.b64decode(self.secret_key)
        signature = hmac.new(hmac_key, message, hashlib.sha256)
        signature_b64 = signature.digest().encode('base64').rstrip('\n')

        request.headers.update({
            'CB-ACCESS-SIGN': signature_b64,
            'CB-ACCESS-TIMESTAMP': timestamp,
            'CB-ACCESS-KEY': self.api_key,
            'CB-ACCESS-PASSPHRASE': self.passphrase,
            'Content-Type': 'application/json'
        })
```

Hier staat hoe de headers moeten worden opgebouwd.