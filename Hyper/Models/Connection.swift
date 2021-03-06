//
//  Connection.swift
//  Pizza
//
//  Created by MacBook Pro on 1/3/17.
//  Copyright © 2017 Old Warriors. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// on success request
public typealias ConnectionSuccess = (_ object:JSON) -> Void
// on failed request
public typealias ConnectionFailed = (_ error:Error?) -> Void

class Connection: NSObject {
    
     
 
    enum URLS_Post_Enum {
        case fB_Login
        case google_Login
        case email_Login
        case signup_User
        case edit_Profile
        func stringValue() -> String {
             switch self {
            case .fB_Login:
                return Constant.main_url  + "User/facebook_login"
             case .google_Login:
                return Constant.main_url  + "User/google_login"
             case .email_Login:
                return Constant.main_url  + "User/user_login"
             case .signup_User:
                return Constant.main_url  + "User/user_signup"
             case .edit_Profile:
                return Constant.main_url  + "User/edit_profile"

            }
        }
    }
    
    func getProductData(jData : JSON) -> ProductFull_Data {
        
        
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
        return  productFull_Data
    }
//    enum URLS_Get_Enum {
//        case Item_Details
//
//
//        func stringValue() -> String {
//            switch self {
//            case .Item_Details: return  main_url + "General/get_item_details_by_id?ProductId=1"
//
//            }
//        }
//    }
    //get
    
    class public func performGet(urlString:String,success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
    {
        let headers:[String:String] = ["Authorization":"627562626c6520617069206b6579"]
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        Alamofire.request(escapedString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200 ..< 501).responseJSON { (response) in
            handleResponse(response: response, success: success, failure: failure)
            }.responseString{ (response) in
//                print(response)
        }
    }
//    class public func performGetWithToken(urlString:String,success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
//    {
//        let headers:[String:String] = ["Content-Type":"application/x-www-form-urlencoded","Access-Token":DTOUser.access_token()]
//        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
//        Alamofire.request(escapedString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200 ..< 501).responseJSON { (response) in
//            handleResponse(response: response, success: success, failure: failure)
//            }.responseString{ (response) in
//                print(response)
//        }
//    }

    //post
    class public func performPost(urlString:String,extraHeaders:[String:String]?,postData:[String:Any],success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
    {
        let headers:[String:String] = ["Authorization":"627562626c6520617069206b6579"]
//        headers["Content-Type"]  = "application/json"
//        if let dic = extraHeaders {
//            for item in dic{
//                headers[item.key] = item.value
//            }
//        }
        print(headers)
        
        Alamofire.request(urlString, method: .post, parameters: postData, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200 ..< 501)
            .responseJSON { response in
                handleResponse(response: response, success: success, failure: failure)
            }
            .responseString { (response) in
                print(response)
        }
        
    }
//    class public func performPostWithToken(urlString:String,postData:[String:Any],success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
//    {
//        let headers = ["Access-Token":DTOUser.access_token()]
//        self.performPost(urlString: urlString, extraHeaders: headers, postData: postData, success: success, failure: failure)
//
//    }
//
//    class public func performPut(urlString:String,success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
//    {
//        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
//        Alamofire.request(urlString, method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200 ..< 501)
//            .responseJSON { response in
//                handleResponse(response: response, success: success, failure: failure)
//            }.responseString{ (response) in
//                print(response)
//        }
//
//    }
    //delete
//    class public func performDelete(urlString:String,success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
//    {
////        let url = Foundation.URL(string:urlString)!
//        let headers:[String:String] = ["Authorization":"627562626c6520617069206b6579"]
//
//        Alamofire.request(urlString, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200 ..< 501)
//            .responseJSON { response in
//            handleResponse(response: response, success: success, failure: failure)
//        }
//    }

    //handling
    class private func handleResponse(response:DataResponse<Any>,success:@escaping ConnectionSuccess,failure:@escaping ConnectionFailed)
    {
        switch response.result {
        case .success(let value):
            guard let ss = value as?  [String:Any] else {
                let errorTemp = NSError(domain:"", code:401, userInfo:[:] as? [String : Any])
                failure(errorTemp)
                 return
            }
             print(ss["error"])
            let json = JSON(value)
            if let error = json["error"].string , error == "invalid_token"
            {
                   let userInfo: [AnyHashable : Any] =
                    [
                        NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "invalid_token", comment: "") ,
                        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "invalid_token", comment: "")
                ]
                let errorTemp = NSError(domain:"", code:401, userInfo:userInfo as? [String : Any])
                failure(errorTemp)
            }else
            {
                success(json)
            }
        case .failure(let error):
            print(error.localizedDescription)
            failure(error)
        }
    }
    
}
