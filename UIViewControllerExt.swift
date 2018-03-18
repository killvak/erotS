//
//  UIViewControllerExt.swift
//  Hyper
//
//  Created by admin on 3/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import XLActionController

extension UIViewController {
    
    
    func hideKeyboardWhenTapped() {
        
        let tap  = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    func setupNav() {
        let navV = NavigationBarView()
//        navV.translatesAutoresizingMaskIntoConstraints = false
        navV.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 64)
        self.view.addSubview(navV)
        navV.titleS = title ?? ""
        navV.backBtn.addTarget(self , action: #selector(dismissPushedView), for: .touchUpInside)
        

    }
    
    @objc func dismissPushedView() {
        
        self.navigationController?.popViewController(animated: true)
 
     }
    
    
    func getItemDetails(id : Int ) {
        ad.isLoading()
        Get_Requests().item_Details(item_ID: id, completion: { (rData ) in
//            let data = self.top_products[indexPath.row]
            ad.killLoading()
            let sb = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ItemsDetailsVC") as! ItemsDetailsVC
            vc.data = rData
            vc.title = rData.productsData?.name
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    
    
    func showMoreMenu() {
        
        let actionController = YoutubeActionController()
        
        actionController.addAction(Action(ActionData(title: L0A.Add_To_Cart.stringValue(), image: UIImage(named: "ic_cart_unactive_")!), style: .default, handler: { action in
            if let tabItems = self.tabBarController?.tabBar.items as NSArray!
            {
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[4] as! UITabBarItem
                tabItem.badgeValue = "1"
                
            }

        }))
        actionController.addAction(Action(ActionData(title: L0A.Visit_Category.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
            
            self.tabBarController?.selectedIndex = 1
        }))
        actionController.addAction(Action(ActionData(title: L0A.Visit_Brand.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
            let vc = BrandsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        actionController.addAction(Action(ActionData(title: L0A.Share.stringValue(), image: UIImage(named: "yt-share-icon")!), style: .default, handler: { action in
            
            let shareText = "Hello, world!"
            
            if let image = UIImage(named: "yt-add-to-playlist-icon") {
                let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                self.present(vc, animated: true)
            }
            
        }))
        actionController.addAction(Action(ActionData(title: L0A.Cancel.stringValue(), image: UIImage(named: "yt-cancel-icon")!), style: .cancel, handler: nil))
        
        present(actionController, animated: true, completion: nil)
    }
    
    
    func showApiErrorSms(err : String?) {
         print(err )
        DispatchQueue.main.async {
            self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
            ad.killLoading()
        }
     }
    
    
    func openSearchVC() {
        let vc = SearchControllerVC()
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil    )
    }
}


 
