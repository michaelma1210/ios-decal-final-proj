//
//  SwitchViewController.swift
//  ios-final-project
//
//  Created by David Choi on 11/27/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class SwitchViewController: UIViewController {
    
    var userName = ""
    var name = ""
    var active = 0
    var rootRef = FIRDatabase.database().reference()
    

    @IBOutlet var Intro: UILabel!
    
    @IBOutlet var Status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatus()
        
        // Do any additional setup after loading the view.
    }
    
    func setStatus() {
        let user = rootRef.child("UserName").child(userName)
        user.observe(.value, with: { (snapshot) in
            self.name = snapshot.childSnapshot(forPath: "FirstName").value as! String
            self.active = snapshot.childSnapshot(forPath: "Active").value as! Int
            
            self.Intro.text = "Hello " + self.name + "!"
            
            if self.active == 0 {
                self.Status.text = "Busy Bee"
            } else {
                self.Status.text = "Free Flowing"
            }
        })
    }
    

    
    @IBAction func UpdateStatus(_ sender: Any) {
        let user = rootRef.child("UserName").child(userName)
        
//        user.observe(.value, with: { (snapshot) in
//            self.active = snapshot.childSnapshot(forPath: "Active").value as! Int
//        
//        })
//        if self.active == 0 {
//            self.Status.text = "Free Flowing"
//            user.child("Active").setValue(1)
//            
//        } else {
//            self.Status.text = "Busy Bee"
//            user.child("Active").setValue(0)
//            
//        }
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
