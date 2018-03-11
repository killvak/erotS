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
    
    
    
}

