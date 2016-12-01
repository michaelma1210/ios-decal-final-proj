//
//  FriendRequestViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class FriendRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    let allUsers = FIRDatabase.database().reference().child("UserName")
    var friendRequestList = [String]()
    
    
    
    
    override func viewDidLoad() {
        getFriendRequestList()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getFriendRequestList() {
        
        if mainInstance.friendRequestCheck == 1 {
            friendRequestList.removeAll()
            
            let requestList = currentUser.child("FriendRequest")
            
            requestList.observe(.value, with: {(snapshot) in
                
                for friend in snapshot.children {
                    let snapString = String(describing: friend)
                    let parsedString = self.parseUserName(username: snapString)
                    self.friendRequestList.append(parsedString)
                    print(parsedString)
                    
                }
            })
        }
        mainInstance.friendRequestCheck = 0
    }
    
    func parseUserName(username: String) -> String {
        var user = ""
        let currentUserName = username.characters
        
        var checkParse = false
        for character in currentUserName {
            if checkParse {
                if character == ")" {
                    break
                }
                user += character.description
            }
            if character == "(" {
                checkParse = true
            }
        }
        return user
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendRequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = friendRequestList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let acceptAction = UITableViewRowAction.init(style: .normal, title: "Accept", handler: {(rowAction, indexPath) in
            print("Accept action has been pressed")
            
            
            let addFriend = self.friendRequestList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.currentUser.child("FriendRequest").child(addFriend).removeValue()
            
            self.currentUser.child("Friends").child(addFriend).setValue(0)
            self.allUsers.child(addFriend).child("Friends").child(self.currentUser.key).setValue(0)
            
        
        })
        
        acceptAction.backgroundColor = UIColor.green
        
        let notNowAction = UITableViewRowAction.init(style: .default, title: "Not now", handler: {(rowAction, indexPath) in
            print("Not now action has been pressed")
            
            let removedFriend = self.friendRequestList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.currentUser.child("FriendRequest").child(removedFriend).removeValue()
            
            
            
        })
        
        return [notNowAction, acceptAction]
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
