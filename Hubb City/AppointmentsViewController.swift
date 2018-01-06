//
//  AppointmentsViewController.swift
//  Hubb City
//
//  Created by Brandon  Wade on 1/3/18.
//  Copyright © 2018 Hubbcity. All rights reserved.
//

import UIKit
import Firebase


class AppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   //defining firebase reference var
   var ref: DatabaseReference!
    
   //list to store all the appointments
   var appointmentList = [AppointmentModel]()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableViewAppointments: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentsTableViewCell
        
        //the artist object
        let appointment: AppointmentModel
        
        //getting the artist of selected position
        appointment = appointmentList[indexPath.row]
        
        //adding values to labels
        cell.labelDate.text = appointment.date
        cell.labelService.text = appointment.service
        cell.labelTime.text = appointment.time
        
        //returning cell
        return cell
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        ref = Database.database().reference().child("users").child((user?.uid)!)
      
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.appointmentList.removeAll()
                
                //iterating through all the values
                for appointments in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let appointmentObject = appointments.value as? [String: AnyObject]
                    let date  = appointmentObject?["Day"]
                    let service  = appointmentObject?["Service"]
                    let time = appointmentObject?["Time"]
                    self.statusLabel.text = (appointmentObject?["Status"] as! String)
                    
                    
                    //creating artist object with model and fetched values
                    let appointment = AppointmentModel(date: date as! String?, service: service as! String?, time: time as! String?)
                    
                    //appending it to list
                    self.appointmentList.append(appointment)
                }
                
                //reloading the tableview
                self.tableViewAppointments.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
