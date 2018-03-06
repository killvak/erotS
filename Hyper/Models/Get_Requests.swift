//
//  Get_Requests.swift
//  Hyper
//
//  Created by admin on 3/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Get_Requests : Connection {
    
    
    func item_Details(item_ID : Int ,completion:@escaping ( ItemDetails_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        print(self.get_itemDetails(product_ID: item_ID))
        Connection.performGet(urlString: self.get_itemDetails(product_ID: item_ID), success: { (jData) in
            
            let itemD  = ItemDetails_Data()
            let productD = jData["product"]
            let relatedPrs = jData["related"].arrayValue
            
            itemD.productsData =  Product_Data(productD)
//            var relatedData : [Product_Data] = []
            for x in relatedPrs {
                itemD.relatedProducts.append(Product_Data(x))
            }
            print("itemD.relatedProducts  \(itemD.relatedProducts.count) itemD.productsData \(itemD.productsData?.description)")
            
            completion(itemD)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
        
 
    }
    
    
    
    
    func homeDetails_Request( completion:@escaping ( HomePage_Data ) -> (),failure failed: @escaping (String?)->() ){
        
         Connection.performGet(urlString: self.get_HomePage(), success: { (jData) in
            
            let itemD  = HomePage_Data()
            let brands = jData["brands"].arrayValue
            let cats = jData["categories"].arrayValue
            
             for x in brands {
                itemD.brandsData.append(Brands_Data(x))
            }
            for x in cats {
                itemD.categoriesData.append(Categories_Data(x))
            }
            print("brandsData  \(itemD.brandsData.count) categoriesData \(itemD.categoriesData.count)")
            
            completion(itemD)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
      }
    
    
    func brand_By_ID_Request(brandID: Int, page: Int, completion:@escaping ( [Product_Data] ) -> (),failure failed: @escaping (String?)->() ){
        
         Connection.performGet(urlString: self.get_Brands_By_ID(brandID: brandID, page: page), success: { (jData) in
            
              let relatedPrs = jData["product"].arrayValue
            var brandsProducts : [Product_Data] = []
             for x in relatedPrs {
                brandsProducts.append(Product_Data(x))
            }
            print("brandsProducts  \(brandsProducts.count) brandsProducts \(brandsProducts.description)")
            
            completion(brandsProducts)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
        
        
    }
}
