//
//  FaverateController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/7.
//

import UIKit

class FaverateController: UIViewController {
    lazy var tableView:UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    var modelArray=[ColorModel]()
    var faverateTitleArr = [String]()
    
    typealias UpadateModelState = (_ model:ColorModel)->Void
    var updateBlock:UpadateModelState?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configUI()
    }

    
    func configNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.title = "收藏列表"

        let leftItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftItem
   
    }
    
    func configUI()  {
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


}


//MARK:- delegate & datasourse
extension FaverateController:UITableViewDelegate,UITableViewDataSource{
    
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
            cell.btnBlock = { model in
                //跟新cell状态
                cell.model = model

                //此处所有的model都是被收藏的,当再次点击时,取消收藏,移除cell
                let index = self.faverateTitleArr.firstIndex(of: model.title!)
                self.faverateTitleArr.remove(at: index!)
                self.modelArray.remove(at: index!)
                self.tableView .reloadData()
                self.updateBlock!(model)
            }
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


//MARK:- Methods
extension FaverateController{
    
    @objc fileprivate func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
