//
//  HomeViewController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var modelArray=[ColorModel]()
    var collectionView:UICollectionView?
    var autoTimer:Timer?
    var index:Int = 0
    var px:CGFloat = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "home"
        self.navigationItem.titleView?.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        //设置导航栏背景为空图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        configUI()
        configData()
        setTimer()
    }
    
    func configUI() {
        let iconWidth = kUIScreenWidth - 200
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal  //滚动方向
        layout.itemSize = CGSize(width:iconWidth, height:iconWidth)
        
        // 设置CollectionView
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.layer.contents = UIImage(named: "fengjing_0")?.cgImage
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: NSStringFromClass(HomeCell.self))
        self.view.addSubview(collectionView!)
        
        
        let showCardView = UIView()
        showCardView.backgroundColor = UIColor.randomColor
        showCardView.layer.cornerRadius = 30
        self.view.addSubview(showCardView)
        showCardView.layer.shadowColor = UIColor.randomColor.cgColor
        showCardView.layer.shadowOffset = CGSize(width: 5, height: -15)
        showCardView.layer.shadowOpacity = 0.15
        showCardView.layer.borderWidth = 2
        
        
        let ctview = CTView()
        ctview.backgroundColor = .clear
        showCardView.addSubview(ctview)
                
        collectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(kUIScreenWidth - 100)
        }
        
        showCardView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView!.snp.bottom).offset(20)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.bottom.equalTo(-100)
        }
        
        ctview.snp.makeConstraints { (make) in
            make.center.equalTo(showCardView)
            make.width.equalTo(200)
            make.height.equalTo(300)

        }
        
        
        let inner:CATransform3D = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        ctview.layer.transform = inner;
        
    }
    
    func setTimer() {
        autoTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
    }
    
    @objc func scroll(){
        index = index + 1
        px = px + 10
        index = index >= modelArray.count ? 0 :index

        collectionView?.contentOffset.x = (collectionView?.contentOffset.x)! + 0.5

        if (collectionView?.contentOffset.x)! >= (collectionView?.contentSize.width)! - (collectionView?.frame.size.width)! {
            collectionView?.contentOffset.x = 0
        }
        
    }
    
    func configData(){
        let path = Bundle.main.path(forResource: "colors", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonArr = jsonData as! NSArray
                
                for dic in jsonArr {
//                    print(dic as! [String:String])
                    
                    let model:ColorModel = ColorModel.init(JSON: dic as! [String:String])!
//                    print(model.title!,model.rgb!,model.cmyk!,model.hex!)
                    modelArray.append(model)
                    
                }
                    
            } catch let error as Error? {
                print("读取本地数据出现错误!",error!)
            }
    }
    
    
    /// MARK :delegate &datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HomeCell.self), for: indexPath)
        
        if let cell = cell as? HomeCell {
            let model = self.modelArray[indexPath.row]
            cell.model = model
        }

        return cell;
        
    }
    
    deinit {
        autoTimer?.invalidate()
    }
    

}


