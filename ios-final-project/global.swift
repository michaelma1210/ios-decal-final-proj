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
    
    func getList(listType: String) {
        
        let friendListOfUser = FIRDatabase.database().reference().child("UserName").child(name).child(listType)
        
        if (self.friendCheck || self.friendRequestCheck) {
        
        friendListOfUser.observe(.value, with: {(snapshot) in
            
            for friend in snapshot.children {
                let snapString = String(describing: friend)
                let parsedString = self.parseUserName(username: snapString)
                if ((listType == "Friends")) {
                    self.friendList.append(parsedString)
                    print(self.friendList.count)
                    print("laksdjflkasjdfkljasdlkfjasklfdklasdjflkasdlkfjaslkjfd")
                }
                if ((listType == "FriendRequest")) {
                    self.friendRequestList.append(parsedString)
                }
                print(parsedString)
                
            }
        })
        }
        friendCheck = false
        friendRequestCheck = false
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
