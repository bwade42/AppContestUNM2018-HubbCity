//
//  Singleton.swift
//  Hubb City
//
//  Created by Brandon  Wade on 1/4/18.
//  Copyright © 2018 Hubbcity. All rights reserved.
//

import Foundation

/** This class stores variables that will be accessed throughout multiple classes **/
final class Singleton
{
    static let sharedInstance = Singleton()
    var isSignIn: Bool
    var isAdmin: Bool
    //This prevents others from using the default '()' initializer for this class.
    private init()
    {
        isSignIn = false //Set to true if the user in the sign in page
        isAdmin = false //Set to true if the user is signed into an admin account
    }
    
    
    
}

