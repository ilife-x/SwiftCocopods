//
//  AppDelegate.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseTabbarController()
        window?.makeKeyAndVisible()
        
        return true
    }

  


}

