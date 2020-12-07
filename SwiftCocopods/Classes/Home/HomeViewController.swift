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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "home"
        self.navigationItem.titleView?.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        configUI()
        configData()
    }
    
    func configUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal  //滚动方向
        layout.itemSize = CGSize(width:(kUIScreenWidth - 150), height:(kUIScreenWidth - 150))
        // 设置CollectionView
        let collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: NSStringFromClass(HomeCell.self))
        self.view.addSubview(collectionView)
        
        
        let showCardView = UIView()
        showCardView.backgroundColor = UIColor.randomColor
        showCardView.layer.cornerRadius = 30
        self.view.addSubview(showCardView)
        showCardView.layer.shadowColor = UIColor.randomColor.cgColor
        showCardView.layer.shadowOffset = CGSize(width: 5, height: -15)
        showCardView.layer.shadowOpacity = 0.45
        showCardView.layer.borderWidth = 2
        
        
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(kUINavigationBarHeight)
            make.left.right.equalTo(0)
            make.height.equalTo(kUIScreenWidth - 120)
        }
        
        showCardView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.bottom.equalTo(-100)
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
                    print(dic as! [String:String])
                    
                    let model:ColorModel = ColorModel.init(JSON: dic as! [String:String])!
                    print(model.title!,model.rgb!,model.cmyk!,model.hex!)
                    modelArray.append(model)
                    
                }
                    
            } catch let error as Error? {
                print("读取本地数据出现错误!",error!)
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HomeCell.self), for: indexPath)
        
        if let cell = cell as? HomeCell {
            let model = self.modelArray[indexPath.row]
            cell.backgroundColor = .white
            cell.model = model
        }

        return cell;
        
    }
    


    
    @objc func touchView(box:UIView) {
        print("----")
    }
    


}


