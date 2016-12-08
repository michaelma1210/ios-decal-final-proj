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
    
    var invitedBuddiesToSendBack = [String]()
    
//    var friendArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        friendList = mainInstance.friendList

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewEventVC" {
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getFriendsFromSelectedRows() {
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
        let selectedRows = tableView.indexPathsForSelectedRows
        for value in selectedRows! {
            let name = friendList[value.row]
            allUsers.child(mainInstance.name).child("InvitedFriends").child(name).setValue(0)
            
//            mainInstance.invitedBuddiesToSendBack.append(temp)
        }
               
        dismiss(animated: true, completion: nil)
//        

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
