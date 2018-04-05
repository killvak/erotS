//
//  ReloadApp.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    
    
    func reload() {
        let storyb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        tabBar = storyb.instantiateViewController(withIdentifier: "rootNav") as? UITabBarController
        tabBar?.tabBar.items?[4].badgeValue = true ? "1" : nil
        tabBar?.selectedIndex = 0
        UIApplication.shared.keyWindow?.rootViewController = tabBar
    }
    
    func reloadWithAnimation() {
        //        self.view.addSubview(self.activityInd)
        //        self.activityInd.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //        self.activityInd.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let ud = UserDefaults.standard
        if (ud.object(forKey: "token") != nil) {
            let storyb = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            tabBar = storyb.instantiateViewController(withIdentifier: "rootNav") as! UITabBarController
            
//            tabBar?.tabBar.items?[2].badgeValue = (ShoppingCart.sharedInstance.itemsArray.count > 0) ? "\(ShoppingCart.sharedInstance.itemsArray.count)" : nil
//            print("\(ShoppingCart.sharedInstance.itemsArray.count)")
            //          }
            tabBar?.selectedIndex = 0
            rootviewcontroller.rootViewController = tabBar
            
            //            rootviewcontroller.rootViewController = storyb.instantiateViewController(withIdentifier: "rootNav")
        }else {
//             let initialViewController = SplashLoginVC(nibName: "SplashLoginVC", bundle: nil)
//             rootviewcontroller.rootViewController = initialViewController
            
        }
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    
    
    func saveUserLogginData(email:String?,photoUrl : String? , uid : Int?,name:String?) {
        //        print("saving User Data email: \(String(describing: email)) , photoUrl: \(String(describing: photoUrl)),uid: \(String(describing: uid)),  , photoUrl: \(String(describing: name))")
        if email != "default" {
            if   let email = email   {
                UserDefaults.standard.setValue(email, forKey: "userEmail")
            }else{
                UserDefaults.standard.setValue(nil, forKey: "userEmail")
                
            }
        }
        if photoUrl != "default" {
            
            if  let photo = photoUrl {
                UserDefaults.standard.setValue(photo, forKey: "profileImage")
                //                print("saing this photo : \(photo)")
            }else {
                UserDefaults.standard.setValue(nil, forKey: "profileImage")
            }
        }
        if uid != -1 {
            
            if  let uid = uid {
                UserDefaults.standard.setValue(uid, forKey: "userId")
            }else {
                UserDefaults.standard.setValue(nil, forKey: "userId")
                UserDefaults.standard.setValue(false, forKey: "hasSentPlayerID")
            }
        }
        if name != "default" {
            
            if let name = name {
                UserDefaults.standard.setValue(name, forKey: "usreName")
            }else {
                UserDefaults.standard.setValue(nil, forKey: "usreName")
            }
        }
    }
    
    func  getUserID() -> Int   {
        guard  let userID = UserDefaults.standard.value(forKey: "userId") as? Int else {
            //        print("error fetching userId from NSUserD.userId")
            return 0
        }
        return userID
    }
    
    func isUserLoggedIn() -> Bool {
 
            guard let _ = UserDefaults.standard.value(forKey: "userEmail") as? String else {
                saveUserLogginData(email: nil, photoUrl: nil, uid: nil, name: nil)
                return false
            }
            return true
     }
    
}

