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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI()  {
        self.title = "详情"
        view.backgroundColor = .white
        
        card = UIView()
        card?.backgroundColor = UIColor(hex: (model!.hex?.appending("FF"))!)
        card?.layer.cornerRadius = 35
//        card?.layer.masksToBounds = true
        card?.layer.shadowColor = UIColor.black.cgColor
        card?.layer.shadowOffset = CGSize(width: 2, height: 2)
        card?.layer.shadowOpacity = 0.4
        view.addSubview(card!)
        
        card?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets(top: kUINavigationBarHeight+50, left: 20, bottom: 200, right: 20))
        })
        
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(share))
        card?.addGestureRecognizer(longPressGes)
    }
    
  @objc  func share() {
        //分享的标题
        let textToShare = "分享的标题:大家好";
        //分享的图片
        let imageToShare:UIImage = UIImage(named: "header_girl")!
        //分享的url
        let urlToShare = URL(string: "http://www.baidu.com")
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        let activityItems:NSArray = [textToShare,imageToShare, urlToShare!];
        let activityVC = UIActivityViewController(activityItems: activityItems as! [Any], applicationActivities: [])
        //不出现在活动项目
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.mail, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact];
        self.present(activityVC, animated: true,completion: nil)
    

        
    
  }
    
}
