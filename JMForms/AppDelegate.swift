//
//  AppDelegate.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 25/07/2020.
//  Copyright © 2020 Codement Aps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ExampleViewController(style: .grouped)
        window?.makeKeyAndVisible()
        
        return true
    }

}

