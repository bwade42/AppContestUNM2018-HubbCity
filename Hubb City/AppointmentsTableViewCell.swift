//
//  AppointmentsTableViewCell.swift
//  Hubb City
//
//  Created by Brandon  Wade on 1/3/18.
//  Copyright © 2018 Hubbcity. All rights reserved.
//

import UIKit
/****************************************************/
/* This class sets up the cell's on the table view */
class AppointmentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelService: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
