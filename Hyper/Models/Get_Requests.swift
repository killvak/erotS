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
            
              let relatedPrs = jData["product"].arrayValue
            let filterBrandData = jData["filter"]["brands"].arrayValue
            let filterCatData = jData["filter"]["categories"].arrayValue
            
            var productFull_Data = ProductFull_Data()
            var maxMinPrice = [Int]()
              for x in relatedPrs {
                 productFull_Data.productList.append(Product_Data(x))
                maxMinPrice.append(Product_Data(x).price)
            }
            productFull_Data.filterData.maxPrice = maxMinPrice.max()
             productFull_Data.filterData.minPrice = maxMinPrice.min()
            for x in filterBrandData {
                productFull_Data.filterData.brands.append(Filter_Listed_Data(x))
            }
            for x in filterCatData {
                productFull_Data.filterData.categories.append(Filter_Listed_Data(x))
            }
            
            
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
    
    
    func category_By_Id(catID: Int, page: Int, completion:@escaping ( Categories_Specefications_Data ) -> (),failure failed: @escaping (String?)->() ){
        
        Connection.performGet(urlString: self.get_Cats_By_ID(catID: catID, page: page), success: { (jData) in
            
            let catData = Categories_Specefications_Data()
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


//MARK: Post_Requests
extension Get_Requests {
    func postSearch(query : String?,min_price : Int? ,max_price : Int?,cats : [Int]?,brands : [Int]?,colors:[Int]?,page : Int,completion:@escaping ( [CatBrand_Data] ) -> (),failure failed: @escaping (String?)->() ) {
        //http://45.55.134.13/api/v1/places/1/8/20
         //        print("URL: is getPlacesList URL : \(url) location is  \(ad.currentLocation)")
        //        print("lat is \(ad.latitude) lon is \(ad.longitude)")
        
          
        let parameters : Parameters = setupSearchParameters(query: query, min_price: min_price, max_price: max_price, cats: cats, brands: brands , colors: colors)
         let url = self.postSearchUrl(page:page)
        var headers:[String:String] = ["Authorization":"627562626c6520617069206b6579"]
        headers["Content-Type"]  = "application/json"
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
//                print(response)
                guard let value = response.value else {
                    failed(response.error?.localizedDescription)
                    return
                }
                let jData = JSON(value)
                var data = [CatBrand_Data]()
                
                let jBrand = jData["filter"]["brands"]
                let jCats = jData["filter"]["categories"]
                
                for (_,j) in jBrand {
                    data.append(CatBrand_Data(j,type: .Brand))
                }
                for (_,j) in jCats {
                    data.append(CatBrand_Data(j,type: .Category))
                }
                completion(data)

                break
            case .failure(let error):
                failed(response.error?.localizedDescription)
                print(error)
            }
        }
    }
//    func postSearch(query : String?,min_price : Int? ,max_price : Int?,cats : [Int]?,brands : [Int]?,colors:[Int]?,page : Int,completion:@escaping ( [CatBrand_Data] ) -> (),failure failed: @escaping (String?)->() ){
//         let parameters : Parameters = setupSearchParameters(query: query, min_price: min_price, max_price: max_price, cats: cats, brands: brands , colors: colors)
//        print(parameters)
//        print(self.postSearchUrl(page:page))
//        Connection.performPost(urlString: self.postSearchUrl(page:page), extraHeaders: nil, postData: parameters, success: { (jData) in
//            print(jData)
//
//            var data = [CatBrand_Data]()
//
//            let jBrand = jData["filter"]["brands"]
//            let jCats = jData["filter"]["categories"]
//
//            for (_,j) in jBrand {
//                data.append(CatBrand_Data(j,type: .Brand))
//              }
//            for (_,j) in jCats {
//                data.append(CatBrand_Data(j,type: .Category))
//            }
//            completion(data)
//        }) { (err ) in
//
//            print(err?.localizedDescription)
//        }
//
//    }
    
    private func setupSearchParameters(query : String?,min_price : Int? ,max_price : Int?,cats : [Int]?,brands : [Int]?,colors:[Int]?) -> Parameters{
        var parameters : Parameters = [:]
        if let q = query   {
            parameters["query"] = q
        }
        if let min =  min_price  {
            parameters["min_price"] =  min
        }
        if let max = max_price {
            parameters["max_price"] =  max
        }
        if  let cat = cats {
            parameters["cats"] =  cat
        }
        if let brand = brands  {
            parameters["brands"] =  brand
        }
        if let color =  colors  {
            parameters["colors"] =  color
            
        }
        return parameters
    }
    
    
    
}
