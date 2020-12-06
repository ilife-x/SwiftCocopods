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
        let homeItem =  UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_selected"))
        homeNav.tabBarItem = homeItem
        
        let colorsNav = UINavigationController(rootViewController:ColorViewController())
        let colorItem =  UITabBarItem(title: "中国色", image: UIImage(named: "colors"), selectedImage: UIImage(named: "colors_selected"))
        let attr = NSMutableDictionary()
        
        attr.setValue(UIColor.gray, forKey: NSAttributedString.Key.foregroundColor.rawValue)
        colorItem.setTitleTextAttributes(attr as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
        
        let attr_s = NSMutableDictionary()
        attr.setValue(UIColor.red, forKey: NSAttributedString.Key.foregroundColor.rawValue)
        colorItem.setTitleTextAttributes(attr_s as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        
        colorsNav.tabBarItem = colorItem
        
        let settingNav = UINavigationController(rootViewController: SettingViewController())
        let setttingItem =  UITabBarItem(title: "Setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting_selected"))
        settingNav.tabBarItem = setttingItem
        
        UINavigationBar.appearance().barTintColor = .white
        UITabBar.appearance().barTintColor = UIColor.white
        

        self.viewControllers = [homeNav,colorsNav,settingNav]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }


}
