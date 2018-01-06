//
//  AppointmentModel.swift
//  Hubb City
//
//  Created by Brandon  Wade on 1/3/18.
//  Copyright © 2018 Hubbcity. All rights reserved.
//

import Foundation
/** This class contains variables used to construct an appointment or schedule **/
class AppointmentModel
{
    var date: String?    // The date of the appointment
    var service: String? //Capret Cleaning/ Auto Detailing/ Car Wash
    var time: String? // Time of the appointment
    
    init(date: String?, service: String?, time: String?)
    {
        self.date = date
        self.service = service
        self.time = time
    }
    
}
