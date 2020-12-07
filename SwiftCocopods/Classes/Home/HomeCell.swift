//
//  HomeCell.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/3.
//

import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    private  var titleLabel: UILabel?
    private var rgbLabel :UILabel?
    private var hexLabel :UILabel?

    public var model:ColorModel{
        set(model){
            titleLabel?.text = model.title
            contentView.backgroundColor = UIColor (hex: (model.hex?.appending("ff"))!)
            contentView.layer.borderColor = UIColor.randomColor.cgColor


            if ((model.title?.contains("白")) == true || model.title?.contains("黄") == true) {
                let randomColor = UIColor.randomColor
                
                titleLabel?.textColor = randomColor

                rgbLabel?.text = "RGB: ".appending(model.rgb!)
                rgbLabel?.textColor = randomColor

                hexLabel?.text = "HEX: ".appending((model.hex?.appending("ff"))!)
                hexLabel?.textColor = randomColor
                
            }else{
                titleLabel?.textColor = .white
                rgbLabel?.text = "RGB: ".appending(model.rgb!)
                hexLabel?.text = "HEX: ".appending((model.hex?.appending("ff"))!)
                
            }

        }
        
        get{return self.model}

    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI() {
        let cardView = UIView()
        contentView.addSubview(cardView)
        contentView.layer.cornerRadius = (kUIScreenWidth-150)/2
        contentView.layer.shadowColor = UIColor.randomColor.cgColor
        contentView.layer.shadowOffset = CGSize(width: 5, height: 15)
        contentView.layer.shadowOpacity = 0.45
        contentView.layer.borderWidth = 2
        
        titleLabel = UILabel()
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.layer.masksToBounds = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 45)
        titleLabel?.textAlignment = .center
        
        rgbLabel = UILabel()
        rgbLabel?.font = UIFont.systemFont(ofSize: 14)
        rgbLabel?.layer.cornerRadius = 5
        rgbLabel?.layer.masksToBounds = true
        rgbLabel?.textAlignment = .right
        
        hexLabel = UILabel()
        hexLabel?.font = UIFont.systemFont(ofSize: 14)
        hexLabel?.layer.cornerRadius = 5
        hexLabel?.layer.masksToBounds = true
        hexLabel?.textAlignment = .right
        
        contentView.addSubview(titleLabel!)
        contentView.addSubview(rgbLabel!)
        contentView.addSubview(hexLabel!)
        
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo(contentView)
        })
        
        rgbLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-30)
            make.centerX.equalTo(contentView)
        })
        
        hexLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(contentView)

        })
        
        
    }
    
    
    
    
    


}
