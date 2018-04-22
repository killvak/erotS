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
 
     func item_Details(item_ID : Int ,completion:@escaping ( ItemDetails_Data ) -> (),failure failed: @escaping (String?)->() ){
        
// print(self.get_itemDetails(product_ID: item_ID))
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
//            print("itemD.relatedProducts  \(itemD.relatedProducts.count) itemD.productsData \(itemD.productsData?.description)")
            
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
            let promotions = jData["promotions"].arrayValue
            
             for x in brands {
                let y = Cat_Brand_Data(x)
                itemD.brandsData.append(y)
             }
            for x in cats {
                let y = Cat_Brand_Data(x)
                itemD.categoriesData.append(Cat_Brand_Data(x))
            }
            for x in promotions {
                itemD.promotionsData.append(Promotions_Data(x))
            }
            print("brandsData  \(itemD.brandsData.count) categoriesData \(itemD.categoriesData.count)")
            
            completion(itemD)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
      }
    
    
    func brand_By_ID_Request(brandID: Int, page: Int, completion:@escaping ( ProductFull_Data ) -> (),failure failed: @escaping (String?)->() ){
        
         Connection.performGet(urlString: self.get_Brands_By_ID(brandID: brandID, page: page), success: { (jData) in
            
//            print(jData)
            let productFull_Data =  self.getProductData(jData: jData)
            productFull_Data._count = jData["count"].int
            completion(productFull_Data)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
      }
    
    
    
    
    func get_Items_By_SuperiorID(isCat: Bool, id: Int, page: Int, completion:@escaping ( [Product_Data] ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.get_Brands_By_ID(brandID: id, page: page), success: { (jData) in
            
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
    
  
    
    func getItem_By_SubCat(id: Int, page: Int, completion:@escaping ( ProductFull_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.get_SubCat_By_ID(subCatID: id, page: page), success: { (jData) in
            
            
            let productFull_Data =  self.getProductData(jData: jData)
            productFull_Data._count = jData["count"].int
            completion(productFull_Data)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    func get_Hot_Items(  page: Int, completion:@escaping ( ProductFull_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.getHotItems(page: page), success: { (jData) in
            
            
            let productFull_Data =  self.getProductData(jData: jData)
            productFull_Data._count = jData["count"].int
            completion(productFull_Data)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    func get_New_Arrivals(  page: Int, completion:@escaping ( ProductFull_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.getNewItems(page: page), success: { (jData) in
            
            
            let productFull_Data =  self.getProductData(jData: jData)
            productFull_Data._count = jData["count"].int
            completion(productFull_Data)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    func category_By_Id(catID: Int, page: Int, completion:@escaping ( Categories_Specefications_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.get_Cats_By_ID(catID: catID, page: page), success: { (jData) in
             let catData = Categories_Specefications_Data()
            catData.cat_id = catID
            let relatedPrs = jData["product"].arrayValue
            var brandsProducts : [Product_Data] = []
            for x in relatedPrs {
                brandsProducts.append(Product_Data(x))
            }
            
            let sub_cat = jData["sub_cat"].arrayValue
            var catsProducts : [Cat_Brand_Data] = []
            for x in sub_cat {
                catsProducts.append(Cat_Brand_Data(x))
            }
             catData.productsData = brandsProducts
            catData.categoriesData = catsProducts
            completion(catData)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    
    func search_Sugettions(  completion:@escaping () -> (),failure failed: @escaping (String?)->() ){
        
        let url = get_Search_Suggestions()
        
        Connection.performGet(urlString: url, success: { (jData) in
            
             let brands = jData["brands"].arrayValue
            let main_cats = jData["main_cats"].arrayValue
            let sub_cats = jData["sub_cats"].arrayValue

             for x in main_cats {
                let y = Cat_Brand_Data(x)
                      Constant.catBrand.append(CatBrand_Data(name: y.name, id: y.id, type: CatBrandType.Category))
             }
            for x in sub_cats {
                let y = Cat_Brand_Data(x)
                 Constant.catBrand.append(CatBrand_Data(name: y.name, id: y.id, type: CatBrandType.subCat))
            }
            for x in brands {
                let y = Cat_Brand_Data(x)
                 Constant.catBrand.append(CatBrand_Data(name: y.name, id: y.id, type: CatBrandType.Brand))
            }
 
            completion()
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    
        
    }

    func all_Data_about(categories: Bool,brands: Bool, page: Int, completion:@escaping ( [Cat_Brand_Data] ) -> (),failure failed: @escaping (String?)->() ){
        
        let url = categories ? self.get_All_Categories(page: page) : get_All_Brands(page: page)
        let jsonKey = categories ? "category": "brand"
        
        Connection.performGet(urlString: url, success: { (jData) in
          
            var catData = [Cat_Brand_Data]()
            let relatedPrs = jData[jsonKey].arrayValue
             for x in relatedPrs {
                let y = Cat_Brand_Data(x)
                catData.append(y)
 
            }
         
           
            
               completion(catData)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    
    func get_Profile_Details(  userID: Int, completion:@escaping ( Profile_Details_M ) -> (),failure failed: @escaping (String?)->() ){
        
        let url = get_Profile_Details(userID :userID )
        
        
        Connection.performGet(urlString: url, success: { (jData) in
            
             let relatedPrs = jData["user"]
                 let y = Profile_Details_M(relatedPrs)
         
             completion(y)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    
    
    func get_Profi2e_Details(  OrderID: Int, completion:@escaping (  ) -> (),failure failed: @escaping (String?)->() ){
        
        let url = get_OrderByID(OrderID :OrderID )
        
        
        Connection.performGet(urlString: url, success: { (jData) in
            //
            //            let relatedPrs = jData["user"]
            //            let y = Profile_Details_M(relatedPrs)
            //
            completion()
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    
    
    func get_User_Orders_List_Request( completion:@escaping ( [OrderDetails_Model] ) -> (),failure failed: @escaping (String?)->() ){
        
        let url = get_User_Orders_List_URL()
        
        
        Connection.performGet(urlString: url, success: { (jData) in
            //
            //            let relatedPrs = jData["user"]
            //            let y = Profile_Details_M(relatedPrs)
            //
            var data : [OrderDetails_Model] = []
            for x in jData["orders"] {
                data.append(OrderDetails_Model(x.1))
             }
             completion(data)
 
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
    
}



extension Get_Requests {
    
    private func get_OrderByID(OrderID : Int) -> String {
        return main_url + "Order/get_order_by_id?OrderID=\(OrderID)"
    }
    
    private func get_H2omePage() -> String {
        return main_url +  "General/home_page"
    }
    
    
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
    private func get_SubCat_By_ID(subCatID : Int,page:Int) -> String {
        //http://hyper-testing.herokuapp.com/api/Category/get_top_items_by_main_category_id?Page=1&MainCategoryID=1
        return main_url + "Category/get_sub_cat_items_by_id?SubCatID=\(subCatID)&Page=\(page)"
    }
    private func get_Search_Suggestions()-> String  {
        
        return main_url + "General/get_suggestions"
    }
    private func get_topItems_By_Brand(brandID : Int,page:Int) -> String {
        return main_url + "Brand/get_brand_items_by_id?BrandId=\(brandID)&Page=\(page)"
    }
    private func get_All_Brands(page:Int) -> String {
        return main_url + "Brand/get_all_brands?Page=\(page)"
    }
    private func get_All_Categories(page:Int) -> String {
        return main_url + "Category/get_main_cats?Page=\(page)"
    }
    
    private func postSearchUrl(page:Int) ->String {
        return main_url + "General/search?Page=\(page)"
    }
    
    private func get_Profile_Details(userID : Int) -> String{
        return main_url + "User/get_user_profile?UserId=\(userID)"
    }
    private func getHotItems(page:Int) ->String {
        return main_url + "General/get_hot_items?Page=\(page)"
    }
    private func getNewItems(page:Int) ->String {
        return main_url + "General/get_new_items?Page=\(page)"
    }
    
    private func get_User_Order(orderID : Int ) -> String{
        return main_url + "Order/get_order_by_id?OrderID=\(orderID)"
    }
    private func get_User_Orders_List_URL() -> String{
        return main_url + "Order/get_user_orders?UserID=\(ad.getUserID())"
    }
    private func cancel_User_Order(orderID : Int ) -> String{
        return main_url + "Order/cancel_order?OrderID=\(orderID)"
    }
}

