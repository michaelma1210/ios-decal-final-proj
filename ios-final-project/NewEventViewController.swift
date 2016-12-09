//
//  NewEventViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 12/1/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController {

    //variables
    let allUsers = FIRDatabase.database().reference().child("UserName")
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    
    var friendList = [String]()
    
    
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var eventDetails: UITextView!

    @IBOutlet var eventPlace: UITextField!
    
    @IBOutlet var eventDateAndTime: UIDatePicker!
    
    override func viewDidLoad() {
        friendList = mainInstance.invitedBuddiesToSendBack

        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func checknotempty() -> Bool {
        if (eventTitle.text?.isEmpty)! {
            // create the alert
            let alert = UIAlertController(title: "Event title empty", message: "Please name your event.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
        } else if (eventDetails.text?.isEmpty)! {
            let alert = UIAlertController(title: "Event details empty", message: "Please add details.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
        } else if (eventPlace.text?.isEmpty)! {
            let alert = UIAlertController(title: "Event place empty", message: "Please add location.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createEvent(_ sender: Any) {
        
        if checknotempty() {
            let invitedFriends = currentUser.child("InvitedFriends")

            let event = currentUser.child("Events")
            let eventTitle = event.child(self.eventTitle.text!)
            eventTitle.child("Creator").setValue(mainInstance.name)
            eventTitle.child("Details").setValue(eventDetails.text)
            eventTitle.child("Place").setValue(eventPlace.text)
            eventTitle.child("DateAndTime").setValue(eventDateAndTime.date.description)
            
            //extra
            mainInstance.eventList.append(self.eventTitle.text!)

            
            invitedFriends.observe(.value, with:{(snapshot) in
                for friend in snapshot.children {
                    let snapString = String(describing: friend)
                    let parsedString = self.parseUserName(username: snapString)
                    let invitedBuddy = self.allUsers.child(parsedString)
                    
                    let event2 = invitedBuddy.child("Events")
                    let eventTitle2 = event2.child(self.eventTitle.text!)
                    eventTitle2.child("Creator").setValue(mainInstance.name)
                    eventTitle2.child("Details").setValue(self.eventDetails.text)
                    eventTitle2.child("Place").setValue(self.eventPlace.text)
                    eventTitle2.child("DateAndTime").setValue(self.eventDateAndTime.date.description)
                    
                    print(parsedString)
                    
                }
            })
            
            invitedFriends.removeValue()
            
            self.dismiss(animated: true, completion: nil)
            
            
            
        }

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
