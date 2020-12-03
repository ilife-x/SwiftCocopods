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
        let homeItem =  UITabBarItem(title: "Home", image: UIImage(named: "home_selected"), tag: 0)
        homeNav.tabBarItem = homeItem
        
        let colorsNav = UINavigationController(rootViewController:ColorViewController())
        let colorItem =  UITabBarItem(title: "Colors", image: UIImage(named: "colors"), selectedImage: UIImage(named: "colors_selected"))
        colorsNav.tabBarItem = colorItem
        
        let settingNav = UINavigationController(rootViewController: SettingViewController())
        let setttingItem =  UITabBarItem(title: "Setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting_selected"))
        settingNav.tabBarItem = setttingItem
        


        self.viewControllers = [homeNav,colorsNav,settingNav]
    }


}
