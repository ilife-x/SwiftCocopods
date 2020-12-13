//
//  SettingViewController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit

class SettingViewController: UIViewController {

    let vc :UIViewController = UIViewController()
    private lazy var popover:PopoverAnimator = PopoverAnimator()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "setting"
//        vc.view.frame = CGRect(x: 0, y: 0, width: kUIScreenWidth, height: 300)
        vc.view.backgroundColor = .red
        vc.view.layer.cornerRadius = 100
        //定义了这个属性,弹出控制器覆盖住的控制器不会被释放,否则下面的控制器会销毁
        vc.modalPresentationStyle = .custom
        //将专场动画代码完全抽离出去，减轻controller代码量
        vc.transitioningDelegate = popover
    
        //添加按钮
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: kUINavigationBarHeight, width: 100, height: 100)
        btn.backgroundColor = .green
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(clickBtn(sender:)), for: .touchUpInside)
        
    }
  

}


// MARK: - button 的点击方法
extension SettingViewController{
    @objc private func clickBtn(sender:UIButton){
        self.present(vc, animated: true, completion: nil)
    }
}

