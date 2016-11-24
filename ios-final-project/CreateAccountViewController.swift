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
    
    func checkCreateAccount() -> Bool {
        var check = false
        if firstName.text!.isEmpty {
            print("Enter first name")
            check = true
        }
        if lastName.text!.isEmpty {
            print("Enter last name")
            check = true
        }
        if userName.text!.isEmpty {
            print("Enter  user-name")
            check = true
        }
        if newPassword.text!.isEmpty {
            print("Enter password")
            check = true
        }
        if phoneNumber.text!.isEmpty {
            print("Enter phone number")
            check = true
        }
        if check {
            return false
        }
        return true
    }
    
    
    @IBAction func CreateAccount(_ sender: Any) {
        if checkCreateAccount() {
            let alias = userName.text
            
            self.rootRef.child("allUsers").observe(.value, with: {FIRDataSnapshot in
                for child in FIRDataSnapshot.children {
                    let name = child
                    print(name)
                }
            })
            
            let user = FIRDatabase.database().reference(withPath: "UserName").child(alias!)
            rootRef.child("allUsers").child(alias!).setValue(0)
            
            user.child("FirstName").setValue(firstName.text!)
            user.child("LastName").setValue(lastName.text!)
            user.child("Password").setValue(newPassword.text!)
            user.child("phoneNumber").setValue(phoneNumber.text!)
        } else {
            print("missing stuff")
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
