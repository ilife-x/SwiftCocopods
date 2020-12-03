//
//  CommonConst.swift
//  SwiftCocopods
//
//  Created by xiao on 2020/12/3.
//

import Foundation
import UIKit
// MARK:- 获取屏幕大小
let kUIScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
let kUIScreenWidth = kUIScreenSize.width
let kUIScreenHeight = kUIScreenSize.height
let kUIScreenBounds = UIScreen.main.bounds

//判断 iPhone 的屏幕尺寸
let kSCREEN_MAX_LENGTH = max(kUIScreenWidth, kUIScreenHeight)
let kSCREEN_MIN_LENGTH = min(kUIScreenWidth, kUIScreenHeight)

//机型判断
let kUI_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
let kUI_IPHONE5 = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
let kUI_IPHONE6 = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
let kUI_IPHONEPLUS = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 736.0)
let kUI_IPHONEX = (kUI_IPHONE && kSCREEN_MAX_LENGTH > 780.0)

//获取状态栏、标题栏、导航栏高度
let kUIStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let kUINavigationBarHeight: CGFloat =  kUI_IPHONEX ? 88 : 44
let KUITabBarHeight: CGFloat = kUI_IPHONEX ? 83 : 49
//navigationBarHeight默认高度44 （iPhoneX 88）
//tabBarHeight默认高度49     （iPhoneX 83）

//适配 350 375 414       568 667 736
func kAutoLayoutWidth(_ width: CGFloat) -> CGFloat {
    return width*kUIScreenWidth / 375
}
func kAutoLayoutHeigth(_ height: CGFloat) -> CGFloat {
    return height*kUIScreenHeight / 667
}


//APP版本号
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
//当前系统版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//检测用户版本号
let kiOS12 = (kVersion >= 12.0)
let kiOS11 = (kVersion >= 11.0 && kVersion < 12.0)
let kiOS10 = (kVersion >= 10.0 && kVersion < 11.0)
let kiOS9 = (kVersion >= 9.0 && kVersion < 10.0)
let kiOS8 = (kVersion >= 8.0 && kVersion < 9.0)
let kiOS12Later = (kVersion >= 12.0)
let kiOS11Later = (kVersion >= 11.0)
let kiOS10Later = (kVersion >= 10.0)
let kiOS9Later = (kVersion >= 9.0)
let kiOS8Later = (kVersion >= 8.0)



extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8{
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = (hexColor.count == 8 ? 0 : 255)

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
    /// 创建一张纯色的图片的方法
    func toImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(self.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
}
