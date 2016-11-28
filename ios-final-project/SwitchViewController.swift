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
    
    
    @IBOutlet var SwitchValue: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("this is it")
        print(userName)
        print("this is it")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
