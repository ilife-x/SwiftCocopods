//
//  HomeViewController.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/2.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    lazy var tableView:UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    var array:[NSString] = ["custom cell",
                            "customNibCell",
                            "custom cell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",
                            "customNibCell",

    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "home"

        tableView.frame = CGRect(x: 0, y: kUINavigationBarHeight, width: kUIScreenWidth, height: kUIScreenHeight-kUINavigationBarHeight-KUITabBarHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        tableView.estimatedRowHeight = 88
        view.addSubview(tableView)
        
        tableView.register(HomeCell.self, forCellReuseIdentifier: NSStringFromClass(HomeCell.self))

    }
    

    
    @objc func touchView(box:UIView) {
        print("----")
    }
    


}


extension HomeViewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HomeCell.self))
        if let cell = cell as? HomeCell {
            cell.selectionStyle = .none
            cell.textLabel?.text = array[indexPath.row] as String
            cell.backgroundColor = UIColor(hex: "#E0EEE8FF")
        }

        return cell!
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print(indexPath.row)
            self.navigationController?.pushViewController(HomeDetailController(), animated: true)
        case 1:
            print(indexPath.row)
            self.navigationController?.pushViewController(HomeDetailController(), animated: true)
        default:
            return
        }
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 88
//    }

}
