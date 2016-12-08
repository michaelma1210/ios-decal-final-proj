//
//  FirstViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/20/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    
    var check = false
    
    @IBOutlet var userName: UITextField!

    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainTabBarController" {
            var src = segue.destination as! mainTabBarController
            src.userName = userName.text!
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "mainTabBarController" {
            
            if check {
                return true
            }
            return false

        }
        if identifier == "CreateAccountViewController" {
            return true
        }
        
        return false
    }
    
    

    @IBAction func LogIn(_ sender: Any) {
        
        
        
        if (userName.text?.isEmpty)! || (password.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "User name or password is empty", message: "Please enter your credentials.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let log = rootRef.child("UserName")
        log.observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.userName.text!) {
                
                let correctPassword : String!
                correctPassword = snapshot.childSnapshot(forPath: self.userName.text!).childSnapshot(forPath: "Password").value as! String!

                if correctPassword == self.password.text {
                    print("That is the correct password")
                    
                    
                    mainInstance.name = self.userName.text!
                    mainInstance.friendRequestCheck = true
                    mainInstance.friendCheck = true
                    mainInstance.getList(listType: "Friends")
                    mainInstance.getList(listType: "FriendRequest")
                    
                    self.check = true
                    self.performSegue(withIdentifier: "mainTabBarController", sender: self)
                    
                } else {
                    let alert = UIAlertController(title: "Invalid Login", message: "The username or password you have entered is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
               
            } else {
                let alert = UIAlertController(title: "Invalid Login", message: "The username or password you have entered is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
        })
        
    }

}

