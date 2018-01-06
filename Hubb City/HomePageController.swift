//
//  HomePageController.swift
//  Hubb City
//
//  Created by Brandon  Wade on 12/26/17.
//  Copyright © 2017 Hubbcity. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    @IBOutlet var HomePageView: UIView!
    
    /** Home Page Buttons **/
    @IBOutlet weak var pricingButton: UIButton!
    @IBOutlet weak var contactusButton: UIButton!
    @IBOutlet weak var viewappointmentsbutton: UIButton!
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var couponButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        definesPresentationContext = true
        modifyButton(containerView: HomePageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /***********************************************************************/
    /***********************************************************************/
    @IBAction func logout(_ sender: UIBarButtonItem)
    {
        let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    /***********************************************************************/
    /***********************************************************************/
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    /***********************************************************************/
    /***********************************************************************/
    func modifyButton(containerView: UIView)
    {
        let margin:CGFloat = 15.0  // 30 works for iphone 7plus
        let middleSpacing:CGFloat = 7.5
        
        self.scheduleButton.tintColor = UIColor.white
        self.scheduleButton.backgroundColor = UIColor.blue
        self.scheduleButton.layer.cornerRadius = 12
        
        
         self.scheduleButton.frame.size.width = (((containerView.frame.size.width - scheduleButton.frame.size.width) - (margin * 2)) / 2 - middleSpacing)
        
        self.viewappointmentsbutton.tintColor = UIColor.white
        self.viewappointmentsbutton.backgroundColor = UIColor.blue
        self.viewappointmentsbutton.layer.cornerRadius = 12
        
        self.pricingButton.tintColor = UIColor.white
        self.pricingButton.backgroundColor = UIColor.blue
        self.pricingButton.layer.cornerRadius = 12
        
        self.contactusButton.tintColor = UIColor.white
        self.contactusButton.backgroundColor = UIColor.blue
        self.contactusButton.layer.cornerRadius = 12
        
        self.couponButton.tintColor = UIColor.white
        self.couponButton.backgroundColor = UIColor.blue
        self.couponButton.layer.cornerRadius = 12
        
    }

}
