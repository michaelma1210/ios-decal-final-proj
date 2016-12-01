//
//  global.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import Foundation

class Main {
    var name:String
    var friendRequestCheck : Int
    init(name:String, friendRequestCheck: Int) {
        self.name = name
        self.friendRequestCheck = friendRequestCheck
        
    }
}
var mainInstance = Main(name: "My Global Class", friendRequestCheck: 1)
