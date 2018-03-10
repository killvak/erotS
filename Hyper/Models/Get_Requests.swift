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
    
    private let main_url = Constant.main_url
    
    private func get_itemDetails(product_ID : Int) -> String {
        return main_url + "General/get_item_details_by_id?ProductId=\(product_ID)"
    }
    
   private func get_HomePage() -> String {
        return main_url +  "General/home_page"
    }
    
   private func get_Brands_By_ID(brandID : Int,page:Int) -> String {
        return main_url + "Brand/get_brand_items_by_id?BrandId=\(brandID)&Page=\(page)"
    }
    private func get_Cats_By_ID(catID : Int,page:Int) -> String {
        //http://hyper-testing.herokuapp.com/api/Category/get_top_items_by_main_category_id?Page=1&MainCategoryID=1
         return main_url + "Category/get_top_items_by_main_category_id?Page=\(page)&MainCategoryID=\(catID)"
    }
   private func get_topItems_By_Brand(brandID : Int,page:Int) -> String {
        return main_url + "Brand/get_brand_items_by_id?BrandId=\(brandID)&Page=\(page)"
    }
     func item_Details(item_ID : Int ,completion:@escaping ( ItemDetails_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        print(self.get_itemDetails(product_ID: item_ID))
        Connection.performGet(urlString: self.get_itemDetails(product_ID: item_ID), success: { (jData) in
            
            let itemD  = ItemDetails_Data()
            let productD = jData["product"]
            let relatedPrs = jData["related"].arrayValue
            
            itemD.productsData =  Product_Data(productD)
//            var relatedData : [Product_Data] = []
            for x in relatedPrs {
                let data = Product_Data(x)
                if data.active {
                itemD.relatedProducts.append(data)
                }
            }
            print("itemD.relatedProducts  \(itemD.relatedProducts.count) itemD.productsData \(itemD.productsData?.description)")
            
            completion(itemD)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
        
 
    }
    
    
    
    
    func homeDetails_Request( completion:@escaping ( HomePage_Data ) -> (),failure failed: @escaping (String?)->() ){
        print(get_HomePage())
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
    
    
    func category_By_Id(catID: Int, page: Int, completion:@escaping ( Categories_Specefications_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.get_Cats_By_ID(catID: catID, page: page), success: { (jData) in
            
            let catData = Categories_Specefications_Data()
            let relatedPrs = jData["product"].arrayValue
            var brandsProducts : [Product_Data] = []
            for x in relatedPrs {
                brandsProducts.append(Product_Data(x))
            }
            
            let sub_cat = jData["sub_cat"].arrayValue
            var catsProducts : [Categories_Data] = []
            for x in sub_cat {
                catsProducts.append(Categories_Data(x))
            }
            print("brandsProducts  \(brandsProducts.count) brandsProducts \(brandsProducts.description)")
            catData.productsData = brandsProducts
            catData.categoriesData = catsProducts
            completion(catData)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
}
