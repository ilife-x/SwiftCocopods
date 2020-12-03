//
//  ColorViewController.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/3.
//

import UIKit
import ObjectMapper
class ColorViewController: UIViewController {
    
    lazy var tableView:UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    var modelArray:[ColorModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData()
    }
    

    func configUI()  {
        self.view.backgroundColor = UIColor.white
        self.title = "Colors"
        tableView.frame = CGRect(x: 0, y: kUINavigationBarHeight, width: kUIScreenWidth, height: kUIScreenHeight - kUINavigationBarHeight - kUIStatusBarHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120

        
        view.addSubview(tableView)
        
        
        tableView.register(ColorCell.self, forCellReuseIdentifier: NSStringFromClass(ColorCell.self))
        
    }
    
    func configData(){
        let path = Bundle.main.path(forResource: "chinaColor", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
            do {
                let data = try Data(contentsOf: url)
                      let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                      let jsonArr = jsonData as! NSArray
                      
                      for dict in jsonArr {
                          print(dict)
                        let model = ColorModel(JSON: dict as! [String : Any] )
                        modelArray?.append(model!)
                        
                      }

                    
            } catch let error as Error? {
                print("读取本地数据出现错误!",error!)
                
            }
                    
    }

}

extension ColorViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ColorCell.self))
        
        cell?.backgroundColor = UIColor.white
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
