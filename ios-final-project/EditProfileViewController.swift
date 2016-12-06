//
//  EditProfileViewController.swift
//  ios-final-project
//
//  Created by Claudia Tse on 12/4/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    
    var first = ""
    var last = ""
    var phone = ""
    var password = ""
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = rootRef.child("UserName").child(mainInstance.name);
        currentUser.observe(.value, with: { (snapshot) in
            self.first = snapshot.childSnapshot(forPath: "FirstName").value as! String
            self.last = snapshot.childSnapshot(forPath: "LastName").value as! String
            self.phone = snapshot.childSnapshot(forPath: "PhoneNumber").value as! String
            self.password = snapshot.childSnapshot(forPath: "Password").value as! String
        })
        
        
        profileImageView.image = UIImage(named: "profile_image.jpeg")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        profileImageView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeProfileImage(_ sender: Any) {
    }
    
    @IBAction func Save(_ sender: Any) {
        
        if !(currentPassword.text?.isEmpty)! && currentPassword.text == self.password {
            if !(firstName.text?.isEmpty)! {
                let firstNamePath = "UserName/" + mainInstance.name + "/FirstName"
                let firstNameRef = rootRef.child(firstNamePath)
                firstNameRef.setValue(firstName.text)
            }
            if !(lastName.text?.isEmpty)! {
                let lastNamePath = "UserName/" + mainInstance.name + "/LastName"
                let lastNameRef = rootRef.child(lastNamePath)
                lastNameRef.setValue(lastName.text)
            }
            if !(phoneNumber.text?.isEmpty)! {
                let phoneNumberPath = "UserName/" + mainInstance.name + "/PhoneNumber"
                let phoneNumberRef = rootRef.child(phoneNumberPath)
                phoneNumberRef.setValue(phoneNumber.text)
            }
            if !(newPassword.text?.isEmpty)! {
                let newPasswordPath = "UserName/" + mainInstance.name + "/Password"
                let newPasswordRef = rootRef.child(newPasswordPath)
                newPasswordRef.setValue(newPassword.text)
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Incorrect Password", message: "Please type current password to save changes.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
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
