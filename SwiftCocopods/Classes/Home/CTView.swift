//
//  CTView.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/8.
//

import UIKit

class CTView: UIView {
//    var str : String?
//
////    override init(frame: CGRect) {
////        if self = super.init(frame: frame) {
////
////        }
////        return self
////    }
//
//    convenience init(str:String){
//        let view = CTView.init
//        view.str = str
//        return
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
    // 空实现会对动画期间的性能产生负面影响.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        
        //调整坐标系
        context!.textMatrix = CGAffineTransform.identity;//设置字形的变换矩阵为不做图形变换
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        let path = CGMutablePath()
        path.addRect(self.bounds)
        
        let attString = "我总想要穿越人海和潮流\n但穿越不了的是你我的鸿沟\nso this way \n 终究还是要自己走\n...\n嗯呀"
//        let attString = str

        
        
        let mutableAttrStr = NSMutableAttributedString(string: attString)
        mutableAttrStr.addAttributes([
                                        .font:UIFont.systemFont(ofSize: 18),
                                        .foregroundColor:UIColor.white,
                                        .verticalGlyphForm:1],
            range:NSRange(location: 0,length: mutableAttrStr.length))
        

        
        let frameMaster = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        let frame = CTFramesetterCreateFrame(frameMaster, CFRangeMake(0, mutableAttrStr.length), path, nil)
        CTFrameDraw(frame, context!)
        
    }

}
