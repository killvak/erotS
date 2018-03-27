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
    
 
    func all_Data_about(categories: Bool,brands: Bool, page: Int, completion:@escaping ( [Cat_Brand_Data] ) -> (),failure failed: @escaping (String?)->() ){
        
        let url = categories ? self.get_All_Categories(page: page) : get_All_Brands(page: page)
        let jsonKey = categories ? "category": "brand"
        
        Connection.performGet(urlString: url, success: { (jData) in
          
            var catData = [Cat_Brand_Data]()
            let relatedPrs = jData[jsonKey].arrayValue
             for x in relatedPrs {
                let y = Cat_Brand_Data(x)
                catData.append(y)
                let typee = categories ?  CatBrandType.Category :  CatBrandType.Brand
                print(jsonKey)
                if !Constant.gotCatSearch , categories{
                Constant.catBrand.append(CatBrand_Data(name: y.name, id: y.id, type: typee))
                }else if !Constant.gotBrandSearch , !categories {
                     Constant.catBrand.append(CatBrand_Data(name: y.name, id: y.id, type: typee))
                }
                
            }
         
            if !Constant.gotCatSearch , categories{
                Constant.gotCatSearch = true
            }else if !Constant.gotBrandSearch , !categories {
                Constant.gotBrandSearch = true
            }
            
               completion(catData)
            
        }) { (err) in
            
            
            failed(err?.localizedDescription)
        }
    }
}



extension Get_Requests {
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
    
    
}

