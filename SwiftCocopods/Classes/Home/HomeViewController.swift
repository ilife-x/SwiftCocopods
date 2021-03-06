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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
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
        self.view.addSubview(showCardView)

        //排版层
        let ctview = CTView()
        let str = "我总想要穿越人海和潮流\n但穿越不了的是你我的鸿沟\nso this way \n 终究还是要自己走\n...\n嗯呀"
        let mStr = NSMutableAttributedString(string:str )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = -10
        mStr.addAttributes([
                .font:UIFont.systemFont(ofSize: 18),
                .foregroundColor:UIColor.white,
                //0:水平绘制文本,1,竖直绘制文本
                .verticalGlyphForm:1,
                .paragraphStyle:paragraphStyle],
            range:NSRange(location: 0,length: mStr.length))
        ctview.mutableAttrStr = mStr
        ctview.backgroundColor = .clear
        showCardView.addSubview(ctview)
        let inner:CATransform3D = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        ctview.layer.transform = inner;
        
        let dateLabel = UILabel()
        dateLabel.layer.cornerRadius = 5
        dateLabel.layer.masksToBounds = true
        dateLabel.text = "24"
        dateLabel.backgroundColor = .white
        dateLabel.layer.cornerRadius = 5
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        dateLabel.textColor = .black
        showCardView.addSubview(dateLabel)

   
        collectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(kUIScreenWidth - 100)
        }
        
        showCardView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView!.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
        }
        
        ctview.snp.makeConstraints { (make) in
            make.center.equalTo(showCardView)
            make.width.equalTo(200)
            make.height.equalTo(300)

        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.width.height.equalTo(60)
        }
        
        

        
    }
    
    func setTimer() {
        autoTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
    }
    
    @objc func scroll(){

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
    


    
    deinit {
        autoTimer?.invalidate()
    }
    

}



// MARK:- delegate &datasource
extension HomeViewController{
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let colorDetailVc = ColorDetailController()
        colorDetailVc.model = model
        self.navigationController?.pushViewController(colorDetailVc, animated: true)
        
        
        
        print("----indexpath\(model)--")
    }
}
