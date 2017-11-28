//
//  ViewController.swift
//  FacebookLoginPoc
//
//  Created by Thom Peele on 27/11/2017.
//  Copyright © 2017 Thom Peele. All rights reserved.
//

import UIKit
import FBSDKLoginKit

//import FacebookLogin


class ViewController: UIViewController {

    var dict : [String : AnyObject]!
    var imageUrl: URL?

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //when login button clicked
    @IBAction func loginButtonClicked(_ sender: FBSDKLoginButton) {
        let loginManager = FBSDKLoginManager()
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
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

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("in loginbutton")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("In logout button")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("in will login")
        return true
    }
    
}

