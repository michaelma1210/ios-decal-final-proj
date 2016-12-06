//
//  NewEventViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 12/1/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //variables
    let allUsers = FIRDatabase.database().reference().child("UserName")
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    
    var friendList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var eventDetails: UITextView!

    @IBOutlet var eventPlace: UITextField!
    
    @IBOutlet var eventDateAndTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = friendList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
            let event = currentUser.child("Events")
            let eventTitle = event.child(self.eventTitle.text!)
            eventTitle.child("Creator").setValue(mainInstance.name)
            eventTitle.child("Details").setValue(eventDetails.text)
            eventTitle.child("Place").setValue(eventPlace.text)
            eventTitle.child("DateAndTime").setValue(eventDateAndTime.date.description)
        
            self.dismiss(animated: true, completion: nil)
            
        }

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
