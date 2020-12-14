//
//  ColorDetailController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/4.
//

import UIKit

class ColorDetailController: UIViewController {

    public var model:ColorModel?
    
    private var card:UIView?
    private var titleLabel:UILabel?
    private var downLoadImageView :UIImageView?
    private var favoriteBtn:UIButton?
    
    private var displayView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.tabBarController?.tabBar.alpha = 0
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.tabBarController?.tabBar.alpha = 1
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.tabBarController?.tabBar.alpha = 1
        }
    }
    
    func configUI()  {
        //设置导航栏背景为空图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.alpha = 0
        view.backgroundColor = UIColor(hex: (model!.hex?.appending("FF"))!)
        
        //添加按钮
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 600, width: 100, height: 100)
        btn.backgroundColor = .green
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(clickBtn(sender:)), for: .touchUpInside)
        
        //长按分享
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(share))
        self.view.addGestureRecognizer(longPressGes)
        
        drawText()
    }
    
    
    @objc func drawText() {
        displayView = UIView(frame: CGRect(x: 20, y: kUINavigationBarHeight, width: 100, height: 50))
//        displayView?.backgroundColor = UIColor.randomColor
        self.view.addSubview(displayView!)
        
        if (model?.title!.count)! > 0 {
            let bezierPath = UIBezierPath().transform(toBezierPath: "绯红色")
            
            let layer = CAShapeLayer()
            layer.bounds = bezierPath.cgPath.boundingBox
            layer.position = CGPoint(x: 20, y: kUIStatusBarHeight)
            layer.isGeometryFlipped = true//?
            layer.path = bezierPath.cgPath
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 1
            layer.strokeColor = UIColor.randomColor.cgColor
            
            let animation = CABasicAnimation(keyPath: "strokEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = CFTimeInterval(layer.bounds.size.width / 3)
            layer.add(animation, forKey: nil)
            self.displayView?.layer.addSublayer(layer)
            
            let penImage = UIImage(named: "pen")
            let penLayer = CALayer()
            penLayer.contents = penImage?.cgImage
            penLayer.anchorPoint = CGPoint.zero
            penLayer.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            layer.addSublayer(penLayer)
            
            let penAnimation = CAKeyframeAnimation(keyPath: "position")
            penAnimation.duration = animation.duration
            penAnimation.path = layer.path
            penAnimation.calculationMode = .paced
            penAnimation.isRemovedOnCompletion = false
            penAnimation.fillMode = .forwards
            penLayer.add(penAnimation, forKey: "position")
            
//            penLayer.perform(#selector(removeFromParent), with: nil, afterDelay: penAnimation.duration + 0.5)

        }
    }
    
  @objc  func share() {
        //分享的标题
    let textToShare = model?.title;
        //分享的图片
        let imageToShare:UIImage = UIImage(named: "header_girl")!
        //分享的url
        let urlToShare = URL(string: "http://www.baidu.com")
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        let activityItems:NSArray = [textToShare ?? "color:",imageToShare, urlToShare!];
        let activityVC = UIActivityViewController(activityItems: activityItems as! [Any], applicationActivities: [])
    
        //不出现在活动项目
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.mail, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact];
        self.present(activityVC, animated: true,completion: nil)

  }
    
}

// MARK: - button 的点击方法
extension ColorDetailController{
    @objc private func clickBtn(sender:UIButton){
        /// 整个窗口截屏
//        let image = UIApplication.shared.keyWindow!.asImage()

        /// 某一个单独View截图
       let image = self.view.asImage()

        /// 将转换后的UIImage保存到相机胶卷中
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
