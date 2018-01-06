//
//  ViewController.swift
//  Hubb City
//
//  Created by Donnell Wade on 12/22/17.
//  Copyright © 2017 Hubbcity. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Firebase

class ViewController: UIViewController
{
    @IBOutlet var videoView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /* load the first page of the app */
        self.setupView()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*****************************************************************************************************/
    /* set's up the main page by adding:                                                                  */
    /* A video, a layer that will hold the video(covers entire screen), and a register and sign up button */
    /*****************************************************************************************************/
    func setupView()
    {
        //path to video that will be used for home screen.
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "CarpetCleaning", ofType: "MOV")!)
        
        // Creating AV player object to play video
        let player = AVPlayer(url: path)
        
        // Add a layer that will fill screen with video
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        
        
        self.videoView.layer.addSublayer(newLayer)
        
        newLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        self.textCenter(containerView: videoView) // Text the will fill middle of screen
        player.play() // play the video
        player.isMuted = true // mute the video
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        /* Replay the video again after its finished */
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
        
        self.createButtons(containerView: videoView)
        
    }
    /* Function that takes video back to 0 */
    func videoDidPlayToEnd(_ notification: Notification)
    {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to:kCMTimeZero)
        
    }
    /* Center's text on the middle of the screen */
    func textCenter(containerView: UIView!)
    {
        let half:CGFloat = 1.0 / 2.0
        
        let textLabel = UILabel()
        
        
        textLabel.text = "Hubb City"
        textLabel.font = UIFont(name: "Apple Color Emoji", size: 50.0)
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = UIColor.white
        textLabel.sizeToFit()
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.frame.origin.x = (containerView.frame.size.width - textLabel.frame.size.width) * half
        textLabel.frame.origin.y = (containerView.frame.size.height - textLabel.frame.size.height) * half
        
        
        
        
        /**** Make text go off the screen after 10 seconds ****/
        UIView.animate(withDuration: 10, delay: 10, options: [.curveEaseOut],
                       animations: {
                        textLabel.center.y -= self.view.bounds.height - 25
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        
        containerView.addSubview(textLabel)
    }
    /**********************************************************************************/
    /*         What to do when the Sign In button is pressed on the main page         */
    /*********************************************************************************/
    func signInButtonPressed(sender: UIButton!)
    {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let signInVC: SignInViewController = storyBoard.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        
        
        
        signInVC.buttonTitlePressed = sender.titleLabel?.text
        
        
        let navigationController = UINavigationController(rootViewController: signInVC)
        
        
        self.present(navigationController, animated: true, completion: nil)
        
        Singleton.sharedInstance.isSignIn = true
        
    }
    
    /**********************************************************************************/
    /*         What to do when the Register button is pressed on the main page        */
    /*********************************************************************************/
    func registerButtonPressed(sender: UIButton!)
    {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let signInVC: SignInViewController = storyBoard.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        
        let navigationController = UINavigationController(rootViewController: signInVC)
        
        self.present(navigationController, animated: true, completion: nil)
        
        Singleton.sharedInstance.isSignIn = false
    }
    
    /* Helper function that modifies the positions,style, and size of the register and sign up button */
    func createButtons(containerView: UIView)
    {
        /***** Sign in button modifications  *****/
        let margin:CGFloat = 15.0  // 30 works for iphone 7plus
        let middleSpacing:CGFloat = 7.5
        
        let signIn = UIButton()
        signIn.setTitle("Sign In", for: .normal)
        signIn.setTitleColor(UIColor.black, for: .focused)
        signIn.backgroundColor = UIColor.green
        signIn.tintColor = UIColor.green
        signIn.layer.cornerRadius = 10
        
        /***** Animation for the Button *****/
        signIn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { () in
                        signIn.transform = .identity
        },
                       completion: nil)
        
        
        /**** Placement of the Button *****/
        signIn.frame.size.width = (((containerView.frame.size.width - signIn.frame.size.width) - (margin * 2)) / 2 - middleSpacing)
        signIn.frame.size.height = 40.0
        signIn.frame.origin.x = margin
        signIn.frame.origin.y = ((containerView.frame.size.height - signIn.frame.size.height) - 25)
        
        /* Action when button is tapped */
        signIn.addTarget(self, action: #selector(self.signInButtonPressed), for: UIControlEvents.touchUpInside)
        containerView.addSubview(signIn)
        
        /***** Register Button modifications *****/
        let register = UIButton()
        register.setTitle("Register", for: .normal)
        register.setTitleColor(UIColor.black, for: .focused)
        register.backgroundColor = UIColor.blue
        register.tintColor = UIColor.blue
        register.layer.cornerRadius = 10
        
        /***** Animation for the Button *****/
        register.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { () in
                        register.transform = .identity
        },
                       completion: nil)
        
        /**** Placement of the Button *****/
        register.frame.size.width = (((containerView.frame.size.width - register.frame.size.width) - (margin * 2)) / 2 - middleSpacing)
        register.frame.size.height = 40.0
        register.frame.origin.x = ((containerView.frame.size.width - register.frame.size.width) - margin)
        register.frame.origin.y = ((containerView.frame.size.height - register.frame.size.height) - 25)
        
        
        /* Action when the button is tapped */
        register.addTarget(self, action:  #selector(self.registerButtonPressed), for: UIControlEvents.touchUpInside)
        containerView.addSubview(register)
        
    }
}

