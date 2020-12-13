//
//  PopoverAnimator.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/13.
//

import UIKit

class PopoverAnimator: NSObject {
    var isPresented:Bool = false
    
}


// mark:- delegate
extension PopoverAnimator:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        //自定义 presentationController
        return CCPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        // 返回一个遵守 UIViewControllerAnimatedTransitioning 协议的对象
        isPresented = true
        return self

    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented  = false
        return self
    }
  
    

}


//自定义转场
extension PopoverAnimator:UIViewControllerAnimatedTransitioning{
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
        
        isPresented ? presentAnimation(using: transitionContext) : dismissAnimation(using: transitionContext)

    }
    
    //弹出动画
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
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
    
    //消失动画
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        transitionContext.containerView.addSubview(dismissView)
        dismissView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            //重要：设置为0.0001，表示一个非常小的值，防止一下子消失，苹果对临界值处理不是很好
            dismissView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0001)

        }completion: { (isfinished) in
            if isfinished == true{
                
                transitionContext.completeTransition(true)
                //动画完成，移除view
                dismissView.removeFromSuperview()
            }
        }
    }
}
