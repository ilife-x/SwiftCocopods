//
//  UIBarButtonItem_extension.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/11.
//

import Foundation
extension UIBarButtonItem{
    /// 通过自定义button 初始化 UIBarbuttonItem
    ///
    convenience init(imageName:String,target:Any?,action:Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName), for: .highlighted)
        button.contentMode = .scaleAspectFit
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView:button)
    
    }
    
    /// 通过图片名字创建UIBarbuttonItem
    convenience init(imageName:String) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName), for: .highlighted)
        self.init(customView:button)
    
    }
}
