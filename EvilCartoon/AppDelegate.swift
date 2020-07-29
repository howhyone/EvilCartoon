//
//  AppDelegate.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/6/12.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ECRootTabBarController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

