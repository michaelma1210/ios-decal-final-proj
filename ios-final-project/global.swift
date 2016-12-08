//
//  global.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import Foundation
import Firebase

class Main {
    
    var name:String
    var friendRequestCheck : Bool
    var friendCheck : Bool
    var friendList = [String]()
    var friendRequestList = [String]()
    init(name:String) {
        self.name = name
        self.friendRequestCheck = true
        self.friendCheck = true
        
    }
    
    func getFriendList() {
        
        let friendListOfUser = FIRDatabase.database().reference().child("UserName").child(name).child("Friends")
        
        if (self.friendCheck) {
            friendList.removeAll()
            
        friendListOfUser.observe(.value, with: {(snapshot) in
            
            for friend in snapshot.children {
                let snapString = String(describing: friend)
                let parsedString = self.parseUserName(username: snapString)
                self.friendList.append(parsedString)
                print(self.friendList.count)
                print(parsedString)
                
            }
        })
        }
        self.friendCheck = false
    }

    func getFriendRequestList() {
        
        let friendListOfUser = FIRDatabase.database().reference().child("UserName").child(name).child("FriendRequest")
        
        if (self.friendRequestCheck) {
            friendRequestList.removeAll()
            
            friendListOfUser.observe(.value, with: {(snapshot) in
                
                for friend in snapshot.children {
                    let snapString = String(describing: friend)
                    let parsedString = self.parseUserName(username: snapString)
                    self.friendRequestList.append(parsedString)
                    print(parsedString)
                    
                }
            })
        }
        self.friendRequestCheck = false
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
}
var mainInstance = Main(name: "My Global Class")
