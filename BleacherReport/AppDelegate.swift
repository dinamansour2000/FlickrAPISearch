//
//  AppDelegate.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/26/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
              
              self.window = UIWindow.init(frame: UIScreen.main.bounds)
              //Initialize NavigationController
              let firstScreenViewController = FirstViewController(nibName: "FirstViewController", bundle: nil)
              navigationController = UINavigationController.init(rootViewController: firstScreenViewController)
              self.window?.rootViewController = navigationController
              self.window?.makeKeyAndVisible()
              self.window?.backgroundColor = UIColor.white
        
        return true
    }



}

