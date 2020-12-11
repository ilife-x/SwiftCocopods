//
//  SettingViewController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit

class SettingViewController: UIViewController {

    let vc :UIViewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "setting"
        vc.view.frame = CGRect(x: 0, y: 0, width: kUIScreenWidth, height: 300)
        vc.view.backgroundColor = .red
        //定义了这个属性,弹出控制器覆盖住的控制器不会被释放,否则下面的控制器会销毁
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
    
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

// mark:- delegate
extension SettingViewController:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        //自定义 presentationController
        return CCPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
//        // 返回一个遵守 UIViewControllerAnimatedTransitioning 协议的对象
//        return self
//
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
  
    

}


//自定义转场
extension SettingViewController:UIViewControllerAnimatedTransitioning{
    /// 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.5
    }

    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    //如果转换是交互式的，而不是百分比驱动的交互式转换，则此方法只能是nop。
    /**
     通过转场上下文获取两个view
     //  当前系统只提供两个key
     //   UITransitionContextToViewKey:获取弹出的view
     //   UITransitionContextFromViewKey:获取消失的view
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        //获取要弹出的view
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        //将view添加到container
        transitionContext.containerView.addSubview(presentedView)
        //执行自定义的动画
        presentedView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            presentedView.transform = CGAffineTransform.identity
        } completion: { (_) in
            //告诉上下文已经完成动画
            transitionContext.completeTransition(true)
        }


    }
}
