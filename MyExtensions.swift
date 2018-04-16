//
//  MyExtensions.swift
//  Hyper
//
//  Created by admin on 3/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    func setupApiImage(imagePath : String) {
        guard let url = URL(string: imagePath ) else { return }
        self.af_setImage(
            withURL: url ,
            placeholderImage: UIImage(named: "Splash"),
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
    }
    
    func setupApiImage(imagePath : String,placeHolderImg: UIImage) {
        guard let url = URL(string: imagePath ) else { return }
        self.af_setImage(
            withURL: url ,
            placeholderImage: placeHolderImg,
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
    }
}
extension UILabel {
    
    func strikeIt(text : String)  {
        let attributeString = NSAttributedString(string: text, attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
         self.attributedText = attributeString
    }
}


import CDAlertView
extension UIView {
    func showAlert(_ title : String? , _ sms : String? ,_ alertType : CDAlertViewType ,_ action:( ()->())?) {
        
        
        let alert = CDAlertView(title: title, message: sms, type: alertType)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = CGAffineTransform(scaleX: 3, y: 3)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90 ) / 180 )
            alpha = 0
            action?()
        }
        alert.hideAnimationDuration = 0.55
        alert.show()
    }
    
    func showSimpleAlert(_ title : String? , _ sms : String? ,_ alertType : CDAlertViewType ) {
        
        let smsR = sms
        let alert = CDAlertView(title: title, message: smsR, type: alertType)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = CGAffineTransform(scaleX: 3, y: 3)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90 ) / 180 )
            alpha = 0
        }
        alert.hideAnimationDuration = 0.55
        alert.show()
    }
    
    func emptyTextFieldHandler(_ textF : UITextField,_ title : String,_ sms : String?,_ alertTyper : CDAlertViewType) {
        self.showAlert(title, sms, alertTyper, {
            
            //            textF.becomeFirstResponder()
        })
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension UIColor {
    public class  var lightGreen : UIColor {
        return UIColor(rgb: 0x54BD56) //57AD57
    }
    public class  var deafultGreen : UIColor {
        return UIColor(rgb: 0x57AD57) //57AD57
    }
    public class  var darkGreen : UIColor {
        return UIColor(rgb: 0x4DAD50)
    }
}
extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}


extension UICollectionView {
    func animateCells( ) {
        self.reloadData()
        let cells = self.visibleCells
        //        let tableHeight = tableView.bounds.size.height
        //        let tableWidth = tableView.bounds.size.width
        
        for i in cells {
            let cell = i as UICollectionViewCell
            cell.transform = CGAffineTransform(scaleX: 0.3, y: 0.1).concatenating(CGAffineTransform(translationX: -800, y:0))
        }
        var index = 0
        
        for a in cells {
            let cell = a as UICollectionViewCell
            UIView.animate(withDuration: 1.4, delay: 0.05 * Double(index), usingSpringWithDamping: 0.73, initialSpringVelocity: 0, options: [.curveEaseOut,.allowUserInteraction], animations: {
                cell.transform = .identity
            })
            index += 1
        }
    }
}

extension UITableView {
    func animateCells( ) {
        self.reloadData()
        let cells = self.visibleCells
        //        let tableHeight = tableView.bounds.size.height
        //        let tableWidth = tableView.bounds.size.width
        
        for i in cells {
            let cell = i as UITableViewCell
            cell.transform = CGAffineTransform(scaleX: 0.3, y: 0.1).concatenating(CGAffineTransform(translationX: -800, y:0))
        }
        var index = 0
        
        for a in cells {
            let cell = a as UITableViewCell
            UIView.animate(withDuration: 1.4, delay: 0.05 * Double(index), usingSpringWithDamping: 0.73, initialSpringVelocity: 0, options: [.curveEaseOut,.allowUserInteraction], animations: {
                cell.transform = .identity
            })
            index += 1
        }
    }
}



extension String {
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
                
                if(self.count>=8 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    var ispriceValue : Bool {
        
        let characterset = CharacterSet(charactersIn: "1234567890٠١٢٣٤٥٦٧٨٩")
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
            //            print("string contains special characters")
            return false
        }else {
            return true
        }
    }
    //let pattern = "^(009665|9665|\\+9665|05|5)?(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
    //    func validate(value: String) -> Bool {
    //        let PHONE_REGEX = "^(009665|9665|\\+9665|05|5)?(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
    //        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    //        let result =  phoneTest.evaluate(with: value)
    //        return result
    //    }
    
    var validPhoneNumber : Bool  {
        //        print("that is the phone : \(self)")
        let PHONE_REGEX = "^(009665|9665|\\+9665|05|5)?(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        //        print("that is the phone result : \(result)")
        return result
        
    }
    /*
     انا دخلت
     0 5 0 1 4 7 2 5 8 1
     0511853257
     0 5 1 1 2 3 4 5 6 7
     مدخلشى
     */
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    //To check text field or String is blank or not
    var isBlankOrLessThan3chr: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            guard trimmed.isEmpty , self.characters.count <= 4 else {
                
                return false
            }
            return trimmed.isEmpty
        }
    }
    func isBlankOrLessThan(_ num : Int) -> Bool{
        let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
        guard trimmed.isEmpty , self.characters.count <= num else {
            
            return false
        }
        return trimmed.isEmpty
    }
    
    
    
}
