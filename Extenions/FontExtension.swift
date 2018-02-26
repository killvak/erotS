//
//  UIView+Border.swift
//  Benefactor
//
//  Created by MacBook Pro on 12/31/16.
//  Copyright © 2016 Old Warriors. All rights reserved.
//

import UIKit
import UITextView_Placeholder

let FONT_NAME = L102Language.currentAppleLanguage() == "ar" ? "GE_SS_Two_Light": "GOTHICI"
let BOLD_FONT_NAME =  L102Language.currentAppleLanguage() == "ar" ? "GE_SS_Two_Bold": "GOTHICB"
let EXTRA_FONT_NAME =  L102Language.currentAppleLanguage() == "ar" ? "GE_SS_Two_Medium": "GOTHICBI"
extension UILabel {
    func customizeFont()
    {
        let fontSize =   self.font.pointSize
        self.font = UIFont(name: FONT_NAME, size: fontSize)
    }
    func customizeBoldFont()
    {
        let fontSize =   self.font.pointSize

        self.font = UIFont(name: BOLD_FONT_NAME, size: fontSize)
    }
    func customizezExtraFont()
    {
        let fontSize =   self.font.pointSize
        self.font = UIFont(name: EXTRA_FONT_NAME, size: fontSize)
    }

}

extension UITextField {
    func customizeFont()
    {
        self.font = UIFont(name: FONT_NAME, size: (self.font?.pointSize)!)
        
    }
    func customizePlaceHolder(_ color:UIColor)
    {
        if let txt1  = self.placeholder
        {
            let attributed = NSAttributedString(string: txt1, attributes: [NSAttributedStringKey.foregroundColor : color,NSAttributedStringKey.font:self.font!])
            self.attributedPlaceholder = attributed
            
        }
        
    }
}
extension UITextView {
    func customizeFont()
    {
        self.font = UIFont(name: FONT_NAME, size: (self.font?.pointSize)!)
        
    }
    func customizePlaceHolder(_ color:UIColor)
    {
        if let txt1  = self.placeholder
        {
            let attributed = NSAttributedString(string: txt1, attributes: [NSAttributedStringKey.foregroundColor : color,NSAttributedStringKey.font:self.font!])
            self.attributedPlaceholder = attributed
            
        }
        
    }
}


