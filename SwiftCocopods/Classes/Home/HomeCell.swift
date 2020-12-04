//
//  HomeCell.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/3.
//

import UIKit
import SnapKit

class HomeCell: UITableViewCell {
    
    var iconImage:UIImageView?
    var titleLabel:UILabel?
    var subTitleLabel:UILabel?
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        iconImage = UIImageView(image: UIImage(named: "header_girl"))
        iconImage?.layer.cornerRadius = 40
        iconImage?.layer.masksToBounds = true
        self.contentView.addSubview(iconImage!)
        
        titleLabel = UILabel()
        titleLabel?.text = "美丽的风景标题"
        titleLabel?.backgroundColor = .white
        titleLabel?.textColor = UIColor(hex: "#425066ff")
        self.contentView.addSubview(titleLabel!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.numberOfLines = 0
        subTitleLabel?.backgroundColor = .white
        subTitleLabel?.textColor = UIColor(hex: "#424C50ff")
        subTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        subTitleLabel?.text = "月白天青曙色早，柳绿蝶红山色晓"
        self.contentView.addSubview(subTitleLabel!)
        
        //刷新布局
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {

        iconImage?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(80)
            
        })
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.iconImage!.snp.right).offset(5)
            make.top.equalTo(self.iconImage!.snp.top)
            make.height.equalTo(30)
            make.right.equalTo(-10)
        })
        
        subTitleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(2)
            make.left.right.equalTo(self.titleLabel!)
            make.height.greaterThanOrEqualTo(40)
            make.bottom.equalTo(-10)
        })
    }

}
