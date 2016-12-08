//
//  EventDetailsViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 12/7/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var place: UILabel!
    
    var eventTemp = ""
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.text = eventTemp
        
        let event = rootRef.child("UserName").child(mainInstance.name).child("Events").child(eventTemp)
        event.observe(.value, with: {(snapshot) in
            self.details.text = snapshot.childSnapshot(forPath: "Details").value as! String?
            self.time.text = snapshot.childSnapshot(forPath: "DateAndTime").value as! String?
            self.place.text = snapshot.childSnapshot(forPath: "Place").value as! String?
        })
        
        
//
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
