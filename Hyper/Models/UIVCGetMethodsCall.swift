//
//  UIVCGetMethodsCall.swift
//  Hyper
//
//  Created by admin on 3/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON


extension UIViewController {
    
 
    func navBrandToProductsList(brandID : Int , pageNum : Int, pageTitle: String)  {
        ad.isLoading()
        Get_Requests().brand_By_ID_Request(brandID:brandID, page: pageNum, completion: { [unowned self ](rData) in
            guard rData.productList.count >= 1 else {
                DispatchQueue.main.async {
                    self.view.showSimpleAlert(L0A.Sorry.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .warning)
                    ad.killLoading()
                }
                return
            }
            DispatchQueue.main.async {
                let vc = ProductsListVC(nibName: "ProductsListVC", bundle: nil)
                vc.data = rData.productList
                vc.fullData = rData
                vc.title = pageTitle
                self.navigationController?.pushViewController(vc, animated: true)
                ad.killLoading()
            }
            
            
            
        }) { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    
    
    func navCategoryToProductsList(catID : Int , pageNum : Int, pageTitle: String) {
         ad.isLoading()
        Get_Requests().category_By_Id(catID: catID, page: pageNum, completion: { (rData) in
            
            DispatchQueue.main.async {
                let sb = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "SelectedBrandVC") as! SelectedBrandVC
                vc.mainData = rData
                vc.title = pageTitle
                 self.navigationController?.pushViewController(vc, animated: true)
                ad.killLoading()
            }
        }, failure: { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        })
    }
    
    
//    func naV=(catID : Int , pageNum : Int, pageTitle: String) {
//        ad.isLoading()
//        ad.isLoading()
//        request.all_Data_about(categories: isCat, brands: !isCat, page: 1, completion: { [unowned self ] (rData) in
//
//            DispatchQueue.main.async {
//
//                ad.killLoading()
//
//                let vc = BrandsVC(nibName: "BrandsVC", bundle: nil)
//                vc.data = rData
//                vc.isCat = isCat
//                vc.title = isCat ? L0A.All_Categories.stringValue() : L0A.All_Brands.stringValue()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//
//        }) { [weak self ](err )  in
//
//            self?.showApiErrorSms(err: err )
//        }
//    }
    
    
}
