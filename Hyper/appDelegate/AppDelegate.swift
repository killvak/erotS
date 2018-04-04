//
//  AppDelegate.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import FBSDKLoginKit
import Google
import GoogleSignIn

@available(iOS 10.0, *)
let ad = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var tabBar: UITabBarController?
    private let activityData = ActivityData()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        L102Localizer.DoTheMagic()
        IQKeyboardManager.sharedManager().enable = true

        if let tabBarController = self.window!.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 0
        }
        setupSocialLogin(application,launchOptions)
//                UIApplication.shared.statusBarView?.backgroundColor =  Constant.BackGroundGray
        UIApplication.shared.statusBarStyle = .lightContent
         return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        print(url.relativeString)
          let facebookURLScheme = "fb720813308073066"

        if(url.scheme!.isEqual(facebookURLScheme)) {
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        }
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func setupSocialLogin(_ application: UIApplication, _ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        GIDSignIn.sharedInstance().clientID = "183803063633-gscvp0e9g2kfjlq5akkc81ujufmjiakb.apps.googleusercontent.com";
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

    }
 
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        CoreDataClass.saveContext()
    }

   
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
extension AppDelegate  {
    
    func isLoading() {
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func killLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
