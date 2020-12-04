//
//  ColorCell.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/3.
//

import UIKit

class ColorCell: UITableViewCell {


    private var colorView:UIView?
    private  var titleLabel: UILabel?
    private var rgbLabel :UILabel?
    private var cmykLabel :UILabel?
    private var hexLabel :UILabel?
    private var descLabel :UILabel?

    public  var model:ColorModel{
        set(model){
            
            titleLabel?.text = model.title
            titleLabel?.backgroundColor = UIColor (hex: (model.hex?.appending("ff"))!)

            rgbLabel?.text = "RGB: ".appending(model.rgb!)
            cmykLabel?.text = "CMYK: ".appending(model.cmyk!)
            hexLabel?.text = "HEX: ".appending((model.hex?.appending("ff"))!)
            if model.desc!.isEmpty {
                descLabel?.text =  model.title?.appending(": 少年!我只能说只可意会不可言传")
            }else{
                descLabel?.text = model.desc

            }
            descLabel?.textColor = UIColor (hex: (model.hex?.appending("ff"))!)
            colorView?.backgroundColor = UIColor(hex: (model.hex?.appending("ff"))!)
        }
        get{
           return self.model
        }
        
        

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.layer.shadowOpacity = 0.5
        
        
        colorView = UIView()
        colorView?.layer.cornerRadius = 30
        colorView?.layer.masksToBounds = true
        
        titleLabel = UILabel()
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.layer.masksToBounds = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        
        rgbLabel = UILabel()
        rgbLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cmykLabel = UILabel()
        cmykLabel?.font = UIFont.systemFont(ofSize: 14)
        
        hexLabel = UILabel()
        hexLabel?.font = UIFont.systemFont(ofSize: 14)
        
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFont(ofSize: 15)
        descLabel?.numberOfLines = 0

        
        contentView.addSubview(colorView!)
        contentView.addSubview(titleLabel!)
        contentView.addSubview(rgbLabel!)
        contentView.addSubview(cmykLabel!)
        contentView.addSubview(hexLabel!)
        contentView.addSubview(descLabel!)
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        colorView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(100)
            make.top.left.equalTo(10)
        })
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(self.colorView!.snp.right).offset(6)
            make.height.equalTo(50)
            make.width.equalTo(125)
        })
        
        rgbLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
            make.right.equalTo(-10)
        })
        
        cmykLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(rgbLabel!.snp.bottom).offset(2)
            make.right.equalTo(-10)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
            
        })
        
        hexLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(cmykLabel!.snp.bottom).offset(2)
            make.right.equalTo(-10)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
        })
        
        descLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(colorView!.snp.right).offset(4)
            make.top.equalTo(titleLabel!.snp.bottom).offset(20)
            make.right.equalTo(-10)


        })
    }


}
