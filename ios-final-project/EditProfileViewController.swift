//
//  EditProfileViewController.swift
//  ios-final-project
//
//  Created by Claudia Tse on 12/4/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var currentpassword: UITextField!
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeProfileImage(_ sender: Any) {
    }
    
    @IBAction func Save(_ sender: Any) {
        var currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name);
        
        currentUser.updateProfile({
            FirstName: self.firstName.text,
            LastName: self.lastName.text,
            PhoneNumber: self.phoneNumber.text
        })
//            .then(function() {
//            // Profile updated successfully!
//            // "Jane Q. User"
//            var displayName = user.displayName;
//            // "https://example.com/jane-q-user/profile.jpg"
//            var photoURL = user.photoURL;
//            }, function(error) {
//                // An error happened.
//        });

        self.dismiss(animated: true, completion: nil)
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
