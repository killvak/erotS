//
//  Post_Requests.swift
//  Hyper
//
//  Created by admin on 3/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON




//MARK: Post_Requests
class  Post_Requests : Connection {
    
    private let main_url = Constant.main_url

    
    
     func postSearch(query : String?,min_price : Int? ,max_price : Int?,cats : [Int]?,brands : [Int]?,colors:[Int]?,page : Int,completion:@escaping ( [CatBrand_Data] ) -> (),failure failed: @escaping (String?)->() ) {
        //http://45.55.134.13/api/v1/places/1/8/20
        //        print("URL: is getPlacesList URL : \(url) location is  \(ad.currentLocation)")
        //        print("lat is \(ad.latitude) lon is \(ad.longitude)")
        
        
        let parameters : Parameters = setupSearchParameters(query: query, min_price: min_price, max_price: max_price, cats: cats, brands: brands , colors: colors)
        let url = self.postSearchUrl(page:page)
          Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: Constant.headers).responseJSON {
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
    
    
    func postFilter_data(parms : Parameters,page : Int,completion:@escaping ( ProductFull_Data ) -> (),failure failed: @escaping (String?)->() ) {
        //http://45.55.134.13/api/v1/places/1/8/20
        //        print("URL: is getPlacesList URL : \(url) location is  \(ad.currentLocation)")
        //        print("lat is \(ad.latitude) lon is \(ad.longitude)")
        
        
         let url = self.postSearchUrl(page:page)
        Alamofire.request(url, method: .post, parameters: parms,encoding: JSONEncoding.default, headers: Constant.headers).responseJSON {
            response in
            switch response.result {
            case .success:
                //                print(response)
                guard let value = response.value else {
                    failed(response.error?.localizedDescription)
                    return
                }
                let jData = JSON(value)
                let data = self.getProductData(jData: jData)
                completion(data)
                
                break
            case .failure(let error):
                failed(response.error?.localizedDescription)
                print(error)
            }
        }
    }
    
    
    func defaultPostRequest(postType:URLS_Post_Enum ,parms : Parameters ,completion:@escaping ( JSON ) -> (),failure failed: @escaping (String?)->() ) {
        //http://45.55.134.13/api/v1/places/1/8/20
        //        print("URL: is getPlacesList URL : \(url) location is  \(ad.currentLocation)")
        //        print("lat is \(ad.latitude) lon is \(ad.longitude)")
        
        
        
        Alamofire.request(postType.stringValue(), method: .post, parameters: parms,encoding: JSONEncoding.default, headers: Constant.headers).responseJSON {
            response in
            switch response.result {
            case .success:
                //                print(response)
                guard let value = response.value else {
                    failed(response.error?.localizedDescription)
                    return
                }
                let jData = JSON(value)
                 completion(jData)
                
                break
            case .failure(let error):
                failed(response.error?.localizedDescription)
                print(error)
            }
        }
    }
    
    func social_Login(postType:URLS_Post_Enum ,parms : Parameters ,completion:@escaping ( Profile_Details_M ) -> (),failure failed: @escaping (String?)->() ) {
        //http://45.55.134.13/api/v1/places/1/8/20
        //        print("URL: is getPlacesList URL : \(url) location is  \(ad.currentLocation)")
        //        print("lat is \(ad.latitude) lon is \(ad.longitude)")
         Alamofire.request(postType.stringValue(), method: .post, parameters: parms,encoding: JSONEncoding.default, headers: Constant.headers).responseJSON {
            response in
            switch response.result {
            case .success:
//                                print(response)
                guard let value = response.value else {
                    failed(response.error?.localizedDescription)
                    return
                }
                print(value)
                let jData = JSON(value)
                let userData = jData["user"]
                                guard userData.dictionary != nil else {
                                     failed("\(jData["message_code"].intValue)")
                                     return
                                }
                let y = Profile_Details_M(userData)
            
                completion(y)

                
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
    private func postSearchUrl(page:Int) ->String {
        return main_url + "General/search?Page=\(page)"
    }
    private func  user_addresses_Url() ->String {
        return main_url + "Address/get_user_addresses"
    }
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

