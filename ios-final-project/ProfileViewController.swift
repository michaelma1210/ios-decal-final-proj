//
//  ProfileViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/20/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    var currentUser = ""
    var first = ""
    var last = ""
    var username = ""
    var number = ""
    var rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInfo()

        // Do any additional setup after loading the view.
    }
    
    func loadUserInfo() {
        
        let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
            currentUser.observe(.value, with: { (snapshot) in
            self.first = snapshot.childSnapshot(forPath:
                "FirstName").value as! String
            self.last = snapshot.childSnapshot(forPath:
                "LastName").value as! String
            self.number = snapshot.childSnapshot(forPath:
                "PhoneNumber").value as! String
            
            self.firstName.text = self.first
            self.lastName.text = self.last
            self.userName.text = mainInstance.name
            self.phoneNumber.text = self.number
        })
        
    }

    
    @IBAction func LogOut(_ sender: Any) {
        
        let homeVC = self.storyboard?.instantiateInitialViewController() as! HomeViewController
        
        self.present(homeVC
            , animated: true, completion: nil)
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
