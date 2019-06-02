//
//  UIColor.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UIColor   {
    static func brandDarkGrey() -> UIColor {
        return UIColor.hex("393649")
    }
    
    static func brandLightGrey() -> UIColor {
        return UIColor.hex("A4A6B6")
    }
    
    static func brandPurple() -> UIColor  {
        return UIColor.hex("5B3EF6")
    }
    
    static func brandBlack() -> UIColor  {
        return UIColor.hex("292D33")
    }
    
    static func brandBlue() -> UIColor  {
        return UIColor.hex("4A90E2")
    }
    
    static func backgroundGrey() -> UIColor  {
        return UIColor.hex("F4F4F4")
    }
    
    static func brandPink() -> UIColor  {
        return UIColor.hex("F12E90")
    }
    
    static func brandLightPink() -> UIColor {
        return UIColor.hex("BCACF0")
    }
    
    static func brandSuccess() -> UIColor {
        return UIColor.hex("41F090")
    }
    
    static func brandWarning() -> UIColor   {
        return UIColor.hex("FEC76B")
    }
    
    static func hex(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
