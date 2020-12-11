//
//  CCPresentationController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/11.
//

import UIKit

class CCPresentationController: UIPresentationController {
    let coverView = UIView()

    //在这里更改要弹出的控制器的位置及大小
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        
        presentedView?.frame = CGRect(x: 100, y: 100, width: 200, height: 300)
        //设置背景蒙版
        setupMengBan()
    }
}

extension CCPresentationController{
    //设置蒙版
    func setupMengBan() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.frame = containerView!.bounds
        coverView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
    }
}

extension CCPresentationController{
    @objc private func coverViewClick(){
        print("-----")
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}


