//
//  mainTabBarController.swift
//  ios-final-project
//
//  Created by David Choi on 11/27/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit

class mainTabBarController: UITabBarController {
    
    var userName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchVC = self.childViewControllers.first as! SwitchViewController
        switchVC.userName = userName
        
        
        // Do any additional setup after loading the view.
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
