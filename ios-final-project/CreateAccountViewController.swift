//
//  CreateAccountViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/20/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var userName: UITextField!
    
    @IBOutlet var newPassword: UITextField!
    
    @IBOutlet var phoneNumber: UITextField!
    
    
    let rootRef = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func CreateAccount(_ sender: Any) {
        let alias = userName.text
        
        let user = FIRDatabase.database().reference(withPath: "UserName").child(alias!)
        rootRef.child("allUsers").child(alias!).setValue(0)
        
        user.child("FirstName").setValue(firstName.text!)
        user.child("LastName").setValue(lastName.text!)
        user.child("Password").setValue(newPassword.text!)
        user.child("phoneNumber").setValue(phoneNumber.text!)
        
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
