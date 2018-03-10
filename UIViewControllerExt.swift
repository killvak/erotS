//
//  UIViewControllerExt.swift
//  Hyper
//
//  Created by admin on 3/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    
    func setupNav(_ title : String) {
        let navV = NavigationBarView()
//        navV.translatesAutoresizingMaskIntoConstraints = false
        navV.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 64)
        self.view.addSubview(navV)
        navV.titleS = title
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
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ItemsDetailsVC") as! ItemsDetailsVC
            vc.data = rData
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    
}


 
