//
//  ScheduleController.swift
//  Hubb City
//
//  Created by Brandon  Wade on 1/2/18.
//  Copyright © 2018 Hubbcity. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
class ScheduleController: UIViewController, MFMailComposeViewControllerDelegate {
  
    //Textfields located on schedule appointment
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var service: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    //Fire Databse
    var ref: DatabaseReference!
    var dateTime = ""
    var dateDay = ""
    var status = "Pending"
    
    var badSchedule: Bool!
    /************************************************************************/
    /************************************************************************/
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //getting a reference to the node artists
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        ref = Database.database().reference()
        
        datepicker.addTarget(self, action: #selector(self.handler(sender:)), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /****************************************************************************/
    /* Adds the data from the text on Schedule Appointment page to Fire Database */
    /*****************************************************************************/
    func addData()
    {
        //generating a new key inside  node
        //and also getting the generated key
        let key = ref.childByAutoId().key
        let user = Auth.auth().currentUser
        
        /** Error Checking **/
        if(name.text! == "" || number.text! == "")
        {
            if(name.text! == "")
            {
                self.name.layer.borderColor = UIColor.red.cgColor
                self.name.layer.borderWidth = 1.0
                self.badSchedule = true
            }
            
            if(number.text! == "" )
            {
                self.number.layer.borderColor = UIColor.red.cgColor
                self.number.layer.borderWidth = 1.0
                self.badSchedule = true
            }
        }
        else
        {
            badSchedule = false
        }
        
        if(badSchedule == false)
        {
            //creating schedule with the given values
            let schedule = ["id":key,
                            "Name": name.text! as String,
                            "Phone Number": number.text! as String,
                            "Day": self.dateDay,
                            "Time": self.dateTime,
                            "Service": service.text! as String,
                            "Status": status
            ]
            self.showAlert(title: "You Succesfuly Scheduled an Appointment! Hubb City will Contact you in 1-2 hours to confirm your appointment", message: "Success!")
            
            //adding the schedule inside the generated unique key
            self.ref.child("users").child((user?.uid)!).setValue(["schedule": schedule])
            //ref.child(key).setValue(schedule)
        }
    }
    
    /************************************************************************/
    /* Action when finished button the schedule appointment page is clicked */
    /************************************************************************/
    @IBAction func finished(_ sender: UIButton)
    {
        addData()
    }
    /************************************************************************/
    /* Creates a pop up message / Alert Message                             */
    /************************************************************************/
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /*****************************************************/
    /* UIDatePicker Functionality                        */
    /****************************************************/
    func handler(sender: UIDatePicker)
    {
        /** Retreieve just the time from the UIDatePicker **/
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.full
        let strDate = timeFormatter.string(from: datepicker.date)
        timeFormatter.string(from: datepicker.date)
        self.dateTime = strDate
        
        
        /** Retrieve just the date from the UIDatePicker **/
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let selectedDate = dateFormatter.string(from: datepicker.date)
        self.dateDay = selectedDate
        
    }
    /******************************************************/
    /******************************************************/
    //Calls this function when the tap is recognized.
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
