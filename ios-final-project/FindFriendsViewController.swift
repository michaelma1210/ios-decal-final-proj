//
//  FindFriendsViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class FindFriendsViewController: UIViewController {
    
    @IBOutlet var userNameInput: UITextField!
    
    
    var currentUser = mainInstance.name
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        let allUsers = rootRef.child("UserName")
        
        if (self.userNameInput.text! == currentUser) {
            let alert = UIAlertController(title: "Can't add yourself!", message: "Make some friends yo.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        //start code
        if (!self.userNameInput.text!.isEmpty) {
            
            allUsers.observe(.value, with:
                {(snapshot) in
                    if snapshot.hasChild(self.userNameInput.text!) {
                        let userFound = allUsers.child(self.userNameInput.text!)
                        
                        userFound.child("FriendRequest").child(self.currentUser).setValue(0)
                        let alert = UIAlertController(title: "Friend Request Sent!", message: "Wait for your friend to accept your request.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Username Not Found", message: "You added the wrong person, buddy.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
            })
        } else {
            let alert = UIAlertController(title: "Friend Request Empty", message: "You don't have any friends? 😞", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        //end code
        
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
