//
//  ViewController.swift
//  FacebookLoginPoc
//
//  Created by Thom Peele on 27/11/2017.
//  Copyright © 2017 Thom Peele. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController {

    var dict : [String : AnyObject]!
    var imageUrl: URL?
    var isLoggedIn = false
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = FBSDKLoginButton()
        if (FBSDKAccessToken.current()) != nil {
            getFBUserData()
            isLoggedIn = true
            self.facebookButton.setTitle("Log uit", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

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
                if (result?.isCancelled)!
                {
                    //handle cancelations
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
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender , age_range, timezone, link, location, work, birthday, relationship_status, interested_in, about, education"]).start(completionHandler: { (connection, result, error) -> Void in
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
}


