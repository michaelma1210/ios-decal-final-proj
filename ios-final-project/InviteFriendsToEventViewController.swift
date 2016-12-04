//
//  InviteFriendsToEventViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 12/4/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class InviteFriendsToEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    let allUsers = FIRDatabase.database().reference().child("UserName")
    var friendList = [String]()
    
    var friendArray = [String]()

    

    override func viewDidLoad() {
        getFriendList()

        super.viewDidLoad()
        tableView.allowsMultipleSelection = true


        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getFriendList() {
        
        if mainInstance.friendRequestCheck == 1 {
            friendList.removeAll()
            
            let requestList = currentUser.child("Friends")
            
            requestList.observe(.value, with: {(snapshot) in
                
                for friend in snapshot.children {
                    let snapString = String(describing: friend)
                    let parsedString = self.parseUserName(username: snapString)
                    self.friendList.append(parsedString)
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
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = friendList[indexPath.row]
        
        
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        cell.accessoryType = rowIsSelected ? .checkmark : .none
        // cell.accessoryView.hidden = !rowIsSelected // if using a custom image

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        // cell.accessoryView.hidden = false // if using a custom image
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        // cell.accessoryView.hidden = true  // if using a custom image
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
//        let cell = tableView.cellForRow(at: didSelectRowAt)
//        if cell?.accessoryType == UITableViewCellAccessoryType.none {
//            cell?.accessoryType = .checkmark
//            taskAL[didSelectRowAt.row].checked = true
//            
//            let timeStamp = NSDate()
//            
//            taskAL[didSelectRowAt.row].time = timeStamp
//            
//            
//        } else {
//            cell?.accessoryType = .none
//            taskAL[didSelectRowAt.row].checked = false
//        }
//        tableView.deselectRow(at: didSelectRowAt, animated: true)
//        
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
        let selectedRows = tableView.indexPathsForSelectedRows
//        let selectedData = selectedRows?.map { friendArray[$0.row].ID }

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
