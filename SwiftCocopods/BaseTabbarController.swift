//
//  BaseTabbarController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let homeNav = UINavigationController(rootViewController: HomeViewController())
        let homeItem =  UITabBarItem(title: "home", image: UIImage(named: "home_selected"), tag: 0)
                homeNav.tabBarItem = homeItem
        
        let settingNav = UINavigationController(rootViewController: SettingViewController())
        let setttingItem =  UITabBarItem(title: "setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting_selected"))
        settingNav.tabBarItem = setttingItem

        self.viewControllers = [homeNav,settingNav]
    }


}
