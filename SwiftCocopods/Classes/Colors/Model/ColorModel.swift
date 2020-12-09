//
//  ColorModel.swift
//  SwiftCocopods
//
//  Created by wang xiao on 2020/12/3.
//

import UIKit
import ObjectMapper

class ColorModel: Mappable {
    public var title:String?
    public var hex:String?
    public var rgb:String?
    public var cmyk:String?
    public var desc:String?
    public var slect:Bool = false
 
    required init(map:Map) {

    }
    
    // Mappable
    func mapping(map: Map) {
        title       <- map["title"]
        hex         <- map["HEX"]
        rgb         <- map["RGB"]
        cmyk        <- map["CMYK"]
        desc        <- map["Desc"]


    }
}
