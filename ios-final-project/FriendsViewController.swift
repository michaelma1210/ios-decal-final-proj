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
    
    @IBOutlet weak var tableView: UITableView!
    
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    let allUsers = FIRDatabase.database().reference().child("UserName")
    var friendList = [String]()
    var status = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendList = mainInstance.friendList
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendList = mainInstance.friendList
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendList[indexPath.row]
        
        let friend = allUsers.child(friendList[indexPath.row])
        friend.observe(.value, with: {(snapshot) in
            let temp = snapshot.childSnapshot(forPath: "Active").value as! Int
            mainInstance.temp = temp
            print(mainInstance.temp)
            
            if mainInstance.temp == 1 {
                cell.backgroundColor = UIColor(red: 0.0, green:1.0, blue: 0.0, alpha: 0.3)
            } else {
                cell.backgroundColor = UIColor(red: 1.0, green:0.0, blue: 0.0, alpha: 0.3)
            }
        })
        return cell
    }
}

