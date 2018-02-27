//
//  Constant.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let  BloodyRed =  UIColor.init(hex: "D7080A")
    static let  BackGroundGray =  UIColor.init(hex: "EBEBEC")
    static let  FontColorGray =  UIColor.init(hex: "666666")
    static let  Green =  UIColor.init(hex: "EBEBEC")

    
    
    
}


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

