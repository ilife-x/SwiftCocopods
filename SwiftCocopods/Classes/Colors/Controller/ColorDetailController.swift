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
    private var toolView:UIView?

    private var titleLabel:UILabel?
    private var chineseLabel:UILabel?
    private var rgbLabel :UILabel?
    private var cmykLabel :UILabel?
    private var hexLabel :UILabel?
    private var descLabel :UILabel?
    
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
        view.backgroundColor = .white
        
        let leftItem = UIBarButtonItem(imageName:"back",target: self,action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftItem
        
        //主色卡
        card = UIView()
        card?.backgroundColor = UIColor(hex: (model!.hex?.appending("FF"))!)
        
        titleLabel = UILabel()
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 60)
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .white
//        titleLabel?.backgroundColor = .green
        titleLabel?.text = model?.title
        titleLabel?.numberOfLines = 0
        
        chineseLabel = UILabel()
        chineseLabel?.layer.cornerRadius = 10
        chineseLabel?.layer.masksToBounds = true
        chineseLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        chineseLabel?.textAlignment = .center
        chineseLabel?.textColor = .white
        chineseLabel?.backgroundColor = .green
        chineseLabel?.text = model?.title?.transformToPinYin()
        chineseLabel?.numberOfLines = 0
        
        rgbLabel = UILabel()
        rgbLabel?.font = UIFont.systemFont(ofSize: 14)
        rgbLabel?.layer.cornerRadius = 5
        rgbLabel?.layer.masksToBounds = true
        rgbLabel?.textAlignment = .right
        
        cmykLabel = UILabel()
        cmykLabel?.font = UIFont.systemFont(ofSize: 14)
        cmykLabel?.layer.cornerRadius = 5
        cmykLabel?.layer.masksToBounds = true
        cmykLabel?.textAlignment = .right
        
        hexLabel = UILabel()
        hexLabel?.font = UIFont.systemFont(ofSize: 14)
        hexLabel?.layer.cornerRadius = 5
        hexLabel?.layer.masksToBounds = true
        hexLabel?.textAlignment = .right
        
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFont(ofSize: 15)
        descLabel?.numberOfLines = 0
        
        view.addSubview(card!)
        card?.addSubview(titleLabel!)
        card?.addSubview(chineseLabel!)
        card?.addSubview(rgbLabel!)
        card?.addSubview(cmykLabel!)
        card?.addSubview(hexLabel!)
        card?.addSubview(descLabel!)
        
        //排版层
        let ctview = CTView()
//        let str = "青春\n\t是一场不会回头的风，\n它呼啸而来呼啸而去，\n最终离我们远去，\n一点不剩。"
        let str = """
        我们都在 用力的活着
        爱恨成败 里 赢过也输过\n
        也曾灿烂失落
        无悔选择
        相信磨难历尽 是收获
        成长的路上 有几程曲折
        我以 汗水浇灌 梦想花朵
        任凭谁冷眼 嘲我或轻我
        都会风轻云淡
        一笑而过
"""
        
        let mStr = NSMutableAttributedString(string:str )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = -30
        mStr.addAttributes([
                .font:UIFont.systemFont(ofSize: 18),
                .foregroundColor:UIColor.white,
                //0:水平绘制文本,1,竖直绘制文本
                .verticalGlyphForm:1,
                .paragraphStyle:paragraphStyle],
            range:NSRange(location: 0,length: mStr.length))
        ctview.mutableAttrStr = mStr
        ctview.backgroundColor = .clear
        card?.addSubview(ctview)
        let inner:CATransform3D = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        ctview.layer.transform = inner;
        
        //保存按钮
        let saveBtn = UIButton(type: .custom)
        saveBtn.frame = CGRect(x: 0, y: 600, width:40, height:40)
//        saveBtn.backgroundColor = .green
        view.addSubview(saveBtn)
        saveBtn.setBackgroundImage(UIImage(named: "downLoad"), for: .normal)
        saveBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        
        //分享按钮
        let sharebtn = UIButton(type: .custom)
        sharebtn.frame = CGRect(x: 100, y: 600, width:40, height:40)
//        sharebtn.backgroundColor = .green
        view.addSubview(sharebtn)
        sharebtn.setBackgroundImage(UIImage(named: "share"), for: .normal)

        sharebtn.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        //长按分享
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(share))
        self.view.addGestureRecognizer(longPressGes)
        

        card?.snp.makeConstraints({ (make) in
            make.edges.equalTo(0)
        })
        
        //布局
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(card!.snp.centerX)
            make.top.equalTo(kUIScreenHeight/6)
            make.width.equalTo(80)
            make.height.equalTo(150)
            
        })
        
        ctview.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.equalTo(kUIScreenWidth-100)
//            make.top.equalTo(titleLabel!.snp.bottom).offset(100)
            make.centerX.equalTo(card!.snp.centerX).offset(0)
            make.centerY.equalTo(card!.snp.centerY).offset(100)
        }
        
        
        rgbLabel?.snp.makeConstraints({ (make) in

        })
        
        cmykLabel?.snp.makeConstraints({ (make) in

            
        })
        
        hexLabel?.snp.makeConstraints({ (make) in

        })
        
        descLabel?.snp.makeConstraints({ (make) in

        })
        
        saveBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-40)
            make.width.height.equalTo(35)
        }
        
        sharebtn.snp.makeConstraints { (make) in
            make.left.equalTo(saveBtn.snp.right).offset(50)
            make.width.height.top.equalTo(saveBtn)
        }
 
        
    }
    

    
    

    
}

// MARK: - button 的点击方法
extension ColorDetailController{
    
    //截图保存
    @objc private func save(){
        /// 整个窗口截屏
        //let image = UIApplication.shared.keyWindow!.asImage()
        /// 某一个单独View截图
       let image = self.view.asImage()
        /// 将转换后的UIImage保存到相机胶卷中
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    
    //返回
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //分享
    @objc func share() {
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
