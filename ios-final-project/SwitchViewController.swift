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
    var rootRef = FIRDatabase.database().reference()
    
    @IBOutlet var Status: UILabel!
    @IBOutlet var SwitchValue: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatus()
        
        // Do any additional setup after loading the view.
    }
    
    func setStatus() {
        let user = rootRef.child("UserName").child(userName)
        user.observe(.value, with: { (snapshot) in
            self.name = snapshot.childSnapshot(forPath: "FirstName").value as! String
            
            self.Status.text = "Hello " + self.name + "!"
        
        })
        
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
