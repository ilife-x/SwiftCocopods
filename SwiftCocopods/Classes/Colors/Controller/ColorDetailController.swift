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
    private var faverateBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.navigationController?.navigationBar.alpha = 0
            self.tabBarController?.tabBar.alpha = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.navigationController?.navigationBar.alpha = 1
            self.tabBarController?.tabBar.alpha = 1
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.navigationController?.navigationBar.alpha = 1
            self.tabBarController?.tabBar.alpha = 1
        }
    }
    
    func configUI()  {
        view.backgroundColor = UIColor(hex: (model!.hex?.appending("FF"))!)
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: kUINavigationBarHeight+20, width: 100, height: 50))
        titleLabel?.text = model?.title
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(titleLabel!)
        
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(share))
        self.view.addGestureRecognizer(longPressGes)
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
