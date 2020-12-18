//
//  ColorCell.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/3.
//

import UIKit

class ColorCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configUI()
    }
    
    private var colorView:UIView?
    private  var titleLabel: UILabel?
    private var rgbLabel :UILabel?
    private var cmykLabel :UILabel?
    private var hexLabel :UILabel?
    private var descLabel :UILabel?
    private var favoriteBtn:UIButton?
    
    typealias ButtonClickBlock = (_ model : ColorModel)->Void
    public var btnBlock : ButtonClickBlock?
    var model:ColorModel?{
        didSet{
            contentView.layer.borderColor = UIColor(hex: (model!.hex?.appending("1f"))!)?.cgColor
            contentView.layer.backgroundColor = UIColor(hex: (model!.hex?.appending("0f"))!)?.cgColor
            contentView.backgroundColor = .white
            if model!.selected == true {
                favoriteBtn?.setImage(UIImage(named: "shoucang_selected"), for: .normal)
                favoriteBtn?.setImage(UIImage(named: "shoucang_selected"), for: .highlighted)
            }else{
                favoriteBtn?.setImage(UIImage(named: "shoucang"), for: .normal)
                favoriteBtn?.setImage(UIImage(named: "shoucang"), for: .highlighted)
            }

            let bgcolor = UIColor(hex: (model?.hex?.appending("ff"))!)
            
            colorView?.backgroundColor = bgcolor
            
            titleLabel?.text = model!.title
            
            rgbLabel?.text = "RGB: ".appending(model!.rgb!)
            rgbLabel?.backgroundColor = bgcolor

            cmykLabel?.text = "CMYK: ".appending(model!.cmyk!)
            cmykLabel?.backgroundColor = bgcolor

            hexLabel?.text = "HEX: ".appending((model!.hex?.appending("ff"))!)
            hexLabel?.backgroundColor = bgcolor

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//如果一个方法声明为private,就不会添加到方法列表中,报找不到此方法,如果依然需要添加到方法列表中,就需要添加@objc
   @objc private func favoriateBtnClick(){
        //外面需要model,所以btnBlock 要有参数
        if btnBlock != nil {
            model!.selected = !model!.selected
            self.btnBlock!(model!)
            print("favoriateColor---回'传")
        }
    }
}

// MARK: - 设置界面
extension ColorCell {
    /// 设置界面
    private func configUI() {
        contentView.layer.borderWidth = 1
        
        colorView = UIView()
        colorView?.layer.cornerRadius = 30
        
        titleLabel = UILabel()
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 24)
        titleLabel?.textColor = .black
        titleLabel?.textAlignment = .center
        
        rgbLabel = UILabel()
        rgbLabel?.font = UIFont.systemFont(ofSize: 14)
        rgbLabel?.layer.cornerRadius = 5
        rgbLabel?.layer.masksToBounds = true
        rgbLabel?.textAlignment = .right
        
        cmykLabel = UILabel()
        cmykLabel?.font = UIFont.systemFont(ofSize: 14)
        cmykLabel?.layer.cornerRadius = 5
        cmykLabel?.layer.masksToBounds = true
        cmykLabel?.textAlignment = .right
        
        hexLabel = UILabel()
        hexLabel?.font = UIFont.systemFont(ofSize: 14)
        hexLabel?.layer.cornerRadius = 5
        hexLabel?.layer.masksToBounds = true
        hexLabel?.textAlignment = .right

        descLabel = UILabel()
        descLabel?.font = UIFont.systemFont(ofSize: 15)
        descLabel?.numberOfLines = 0
        
        favoriteBtn = UIButton(type: .custom)
        favoriteBtn?.setImage(#imageLiteral(resourceName: "shoucang_selected"), for: .selected)
        favoriteBtn?.addTarget(self, action: #selector(self.favoriateBtnClick), for: .touchUpInside)

        contentView.addSubview(colorView!)
        contentView.addSubview(titleLabel!)
        contentView.addSubview(rgbLabel!)
        contentView.addSubview(cmykLabel!)
        contentView.addSubview(hexLabel!)
        contentView.addSubview(descLabel!)
        contentView.addSubview(favoriteBtn!)
        
        colorView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(100)
            make.top.left.equalTo(10)
        })
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(self.colorView!.snp.right).offset(6)
            make.height.equalTo(50)
            make.width.equalTo(85)
        })
        
        rgbLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
            make.right.equalTo(-10)
        })
        
        cmykLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(rgbLabel!.snp.bottom).offset(2)
            make.right.equalTo(-40)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
            
        })
        
        hexLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(cmykLabel!.snp.bottom).offset(2)
            make.right.equalTo(-70)
            make.left.equalTo(titleLabel!.snp.right).offset(4)
        })
        
        descLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(colorView!.snp.right).offset(4)
            make.top.equalTo(titleLabel!.snp.bottom).offset(20)
            make.right.equalTo(-10)

        })
        
        favoriteBtn?.snp.makeConstraints({ (make) in
            make.right.bottom.equalTo(-20)
            make.width.height.equalTo(30)
        })
    }
}
