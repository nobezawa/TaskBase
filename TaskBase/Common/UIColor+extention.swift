//
//  UIColor+extention.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static func baseYellow() -> UIColor {
        return UIColor.rgba(red: 254, green: 216, blue: 56, alpha: 1.0)
    }
    
    static func textBlack() -> UIColor {
        return UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
}
