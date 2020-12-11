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
    var modelArray=[ColorModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData()
    }
    
    func configUI()  {
        //设置导航栏
        configNavigationBar()
        
        //主体
        self.view.backgroundColor = UIColor.white
        tableView.frame = CGRect(x: 0, y: kUINavigationBarHeight, width: kUIScreenWidth, height: kUIScreenHeight - kUINavigationBarHeight - kUIStatusBarHeight)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 180
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.register(ColorCell.self, forCellReuseIdentifier: NSStringFromClass(ColorCell.self))
    }
    
    func configNavigationBar() {
        self.title = "中国色"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        
        

        
        
//        let rightBtn1 = UIButton(type:.custom)
//        rightBtn1.setBackgroundImage(UIImage(named: "faverate"), for: .normal)
//        rightBtn1.addTarget(self, action: #selector(jumpToFaverateColorsController), for: .touchUpInside)
//        let faverateItem = UIBarButtonItem(customView: rightBtn1)
//
//        let rightBtn2 = UIButton(type:.custom)
//        rightBtn2.setBackgroundImage(UIImage(named: "delete"), for: .normal)
//        rightBtn2.addTarget(self, action: #selector(jumpToDeleteColorsController), for: .touchUpInside)
//        let deletaItem = UIBarButtonItem(customView: rightBtn2)
        
        let faverateItem = UIBarButtonItem(imageName: "faverate",target: self,action: #selector(jumpToFaverateColorsController))
        let deletaItem = UIBarButtonItem(imageName: "delete",target: self,action: #selector(jumpToDeleteColorsController))
        
        
        
        
        let array :[UIBarButtonItem] = [faverateItem,deletaItem]
        self.navigationItem.rightBarButtonItems = array
        
        
        let leftButton = UIButton(type: .custom)
        leftButton.backgroundColor = .red
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        
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

}


/// MARK - Methods
extension ColorViewController{
    
    @objc fileprivate func jumpToFaverateColorsController(){
        self.navigationController?.pushViewController(FaverateController(), animated: true)
    }
    
    @objc fileprivate func jumpToDeleteColorsController(){
        self.navigationController?.pushViewController(DeleteController(), animated: true)
     }
}


extension ColorViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ColorCell.self))
        cell?.selectionStyle = .none
        
        if let cell = cell as? ColorCell {
            
            let model = self.modelArray[indexPath.row]
            cell.backgroundColor = .white
            cell.model = model
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 180
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray[indexPath.row]
        let colorDetailVc = ColorDetailController()
        colorDetailVc.model = model
        self.navigationController?.pushViewController(colorDetailVc, animated: true)
    }
    
}
