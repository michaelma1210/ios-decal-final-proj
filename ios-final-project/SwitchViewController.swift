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
    
    var currentUser = ""
    var name = ""
    var active = 0
    var rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var statusButton: UIButton!

    @IBOutlet var Intro: UILabel!
    
    @IBOutlet var Status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatus()
        
        let statusButtonImage = UIImage(named: "profile_image.jpeg")
        statusButton.setImage(statusButtonImage, for: UIControlState.normal)
        let statusButtonImageView = self.statusButton.imageView;
        
        statusButtonImageView?.layer.cornerRadius = (self.statusButton.imageView?.frame.size.width)!/2
        
        statusButtonImageView?.clipsToBounds = true;
        
        statusButtonImageView?.layer.borderWidth = 15;
        // Do any additional setup after loading the view.
    }
    
    func setStatus() {
        let statusButtonImageView = self.statusButton.imageView;
        
        let user = rootRef.child("UserName").child(currentUser)
        user.observe(.value, with: { (snapshot) in
            self.name = snapshot.childSnapshot(forPath: "FirstName").value as! String
            self.active = snapshot.childSnapshot(forPath: "Active").value as! Int
            
            self.Intro.text = "Hello " + self.name + "!"
            
            if self.active == 0 {
                self.Status.text = "Busy Bee"
                statusButtonImageView?.layer.borderColor = UIColor(red: 1.0, green:0.0, blue: 0.0, alpha: 0.5).cgColor;
            } else {
                self.Status.text = "Free Flowing"
                statusButtonImageView?.layer.borderColor = UIColor(red: 0.0, green:1.0, blue: 0.0, alpha: 0.5).cgColor;
            }
        })
    }
    

    
    @IBAction func UpdateStatus(_ sender: Any) {
        let user = rootRef.child("UserName").child(currentUser)
        
        user.observe(.value, with: { (snapshot) in
            self.active = snapshot.childSnapshot(forPath: "Active").value as! Int
        
        })
        if self.active == 0 {
            self.Status.text = "Free Flowing"
            user.child("Active").setValue(1)
            
        } else {
            self.Status.text = "Busy Bee"
            user.child("Active").setValue(0)
            
        }
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
