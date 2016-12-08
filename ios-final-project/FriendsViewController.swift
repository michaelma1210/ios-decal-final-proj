//
//  SecondViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/20/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    var friendList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendList = mainInstance.friendList
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friendList.count)
        return friendList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendList[indexPath.row]
        return cell
    }



}

