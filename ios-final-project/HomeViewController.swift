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

    @IBAction func LogIn(_ sender: Any) {
        let log = rootRef.child("UserName")
        log.observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.userName.text!) {
                
                let correctPassword : String!
                correctPassword = snapshot.childSnapshot(forPath: self.userName.text!).childSnapshot(forPath: "Password").value as! String!

                if correctPassword == self.password.text {
                    print("That is the correct password")
                    
                    let tabView = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    
                    self.present(tabView!, animated: true, completion: nil)
                    
                } else {
                    print("That is the incorrect password")
                }
               
            }
            
        })
        
    }

}

