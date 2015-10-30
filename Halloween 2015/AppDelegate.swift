//
//  AppDelegate.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // add scan strats
        costumeManager.addScanner(BeanCostumeScanner())
        
        return true
    }

}

