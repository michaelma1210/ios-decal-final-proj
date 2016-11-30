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

        
        if (self.userNameInput.text!.isEmpty == false) {

            allUsers.observe(.value, with:
                {(snapshot) in
                    if snapshot.hasChild(self.userNameInput.text!) {
                        let userFound = allUsers.child(self.userNameInput.text!)

                        userFound.child("FriendRequest").child(self.currentUser).setValue(0)
                    }
                    
            })
        }
        
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
