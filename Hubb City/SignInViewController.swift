//
//  SignInViewController.swift
//  Hubb City
//
//  Created by Brandon  Wade on 12/24/17.
//  Copyright © 2017 Hubbcity. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    // Textfields located on the sign in and register page
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // planning on deleting this variable
    @IBOutlet weak var CustomerEmployeeController: UISegmentedControl!
    
    //Button located at the bottom of the register page
    @IBOutlet weak var register: UIButton!
    
    //Button located at the bottom of the login page
    @IBOutlet weak var login: UIButton!
    
    //Planning on deleting this variable
    var buttonTitlePressed: String?  // maybe a value or might be nill
    
    //Used for CustomerEmployee Controller planning on deleting
    var isCustomer: Bool! = true
    
    var loginSucessful: Bool!
    var badLogin: Bool!
    
    @IBOutlet weak var adminkey: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        buttonTitlePressed = self.navigationController?.topViewController!.title
        
        self.determineSignInOrRegister()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    /***********************************************************************/
    /***********************************************************************/
    func determineSignInOrRegister()
    {
        /* We are on the register page */
        if(Singleton.sharedInstance.isSignIn == false)
        {
            self.navigationController?.topViewController!.title = "Register"
            self.CustomerEmployeeController.isHidden = false
            self.register.isHidden = false
            print("Register")
            
        }
            /* We are in the login page */
        else
        {
            self.login.isHidden = false
        }
    }
    
    
    /***********************************************************************/
    /***********************************************************************/
    /* Go Back */
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true,completion: nil)
    }
    /***********************************************************************/
    /***********************************************************************/
    @IBAction func register(_ sender: UIButton)
    {
        
        //first take the email and password from the views
        let email = self.username.text
        let password = self.password.text
        let key = "1234"
        
        let adminemail = "hubbcity1@yahoo.com"
        let adminpassword = "jazz4224"
        
        
        // we are in register tab
        if(Singleton.sharedInstance.isSignIn == false)
        {
            
            if(self.username.text! == "" || self.password.text! == "" || self.CustomerEmployeeController.selectedSegmentIndex == -1)
            {
                if(self.username.text == "")
                {
                    self.username.layer.borderColor = UIColor.red.cgColor
                    self.username.layer.borderWidth = 1.0
                    self.badLogin = true
                }
                
                if(self.password.text == "")
                {
                    self.password.layer.borderColor = UIColor.red.cgColor
                    self.password.layer.borderWidth = 1.0
                    self.badLogin = true
                }
                
                
                
                if(self.CustomerEmployeeController.selectedSegmentIndex == -1)
                {
                    self.CustomerEmployeeController.layer.borderColor = UIColor.red.cgColor
                    self.CustomerEmployeeController.layer.borderWidth = 1.0
                    /** Alert now showing bug here **/
                    self.showAlert(title: "Missing Field Required", message: "Fill in or select missing Field(s) in red")
                    self.badLogin = true
                }
                
            }
                
            else
            {
                badLogin = false
            }
            
            if(self.isCustomer == false)
            {
                if(self.adminkey.text! == key)
                {
                    badLogin = false
                }
                    
                else
                {
                    self.adminkey.layer.borderColor = UIColor.red.cgColor
                    self.adminkey.layer.borderWidth = 1.0
                    self.showAlert(title: "Missing Field Required", message: "Fill in or select missing Field(s) in red")
                    badLogin = true
                }
            }
            
            if(badLogin == false && self.isCustomer == true)
            {
                Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
                    if(error == nil)
                    {
                        self.showAlert(title: "You Successfuly Registered", message: "Success!")
                        print("no error")
                    }
                    else
                    {
                        self.showAlert(title: "Error Registering", message: "Error")
                        
                    }
                    
                })
                print("Login Succeeded")
            }
            
            if(badLogin == false && self.isCustomer == false)
            {
                Auth.auth().createUser(withEmail: adminemail, password: adminpassword, completion: { (user, error) in
                    if(error == nil)
                    {
                        self.showAlert(title: "You Successfuly Registered", message: "Success!")
                    }
                    else
                    {
                        self.showAlert(title: "Error Registering", message: "Error")
                        
                    }
                    
                })
                print("Login Succeeded")
            }
            
            
        }
        
    }
    /**********************************************************************************/
    /*   When the user clicks the log in button, the user should be brought           */
    /*   to there dashboard. This functions controlls what happens the Sign In        */
    /*   button is pressed                                                            */
    /*********************************************************************************/
    @IBAction func logInPressed(_ sender: UIButton)
    {
        //Auth.auth().signInAndRetrieveData(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
        //first take the email and password from the views
        let email = self.username.text
        let password = self.password.text
        
        
        if(email == "bwade@unm.edu" && password == "jazz4224")
        {
            Singleton.sharedInstance.isAdmin = true
        }
        
        Auth.auth().signInAndRetrieveData(withEmail: email!, password: password!, completion: { (user, error) in
            if(error == nil)
            {
                self.loginSucessful = true
                
                let viewController: HomePageController = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomePageController
                
                let navigationController = UINavigationController(rootViewController:viewController)
                
                self.present(navigationController, animated: true, completion: nil)
                
            }
                
            else
            {
                self.showAlert(title: "Error Logging in", message: "Error")
                self.loginSucessful = false;
                
            }
            
            
        })
        
    }
    /***********************************************************************/
    /***********************************************************************/
    @IBAction func CustomerEmployeeAction(_ sender: UISegmentedControl)
    {
        /* Customer is in first slot */
        if self.CustomerEmployeeController.selectedSegmentIndex == 0
        {
            self.isCustomer = true
            self.adminkey.isHidden = true
        }
        else
        {
            self.isCustomer = false
            self.adminkey.isHidden = false
        }
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
    //Calls this function when the tap is recognized.
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
