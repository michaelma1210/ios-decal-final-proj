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
        let alias = userName.text! as String

        if checkCreateAccount() {
            self.rootRef.child("allUsers").observe(.value, with: {(snapshot) in
                
                if snapshot.hasChild(alias) {
                    
                        // create the alert
                    let alert = UIAlertController(title: "Username already taken", message: "Please choose a new username.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                    
                else {
                    let user = FIRDatabase.database().reference(withPath: "UserName").child(alias)
                    self.rootRef.child("allUsers").child(alias).setValue(0)
                    
                    user.child("FirstName").setValue(self.firstName.text!)
                    user.child("LastName").setValue(self.lastName.text!)
                    user.child("Password").setValue(self.newPassword.text!)
                    user.child("PhoneNumber").setValue(self.phoneNumber.text!)
                    user.child("Active").setValue(0)
                    
                    let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.present(homeView, animated: true, completion: nil)
                }
            })
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
