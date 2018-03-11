//
//  Constant.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let  BloodyRed =  UIColor.init(hex: "D7080A")
    static let  BackGroundGray =  UIColor.init(hex: "EBEBEC")
    static let  FontColorGray =  UIColor.init(hex: "666666")
    static let  Green =  UIColor.init(hex: "EBEBEC")
    
     static let shared = Constant()
    
    static   let parameters = API.Parameters.shared
    static  let images_Url = "http://arafa.000webhostapp.com/Hyper/uploads/"
  static let main_url = "http://hyper-testing.herokuapp.com/api/"
    private init() {    }
    
    
}
 
class API {
    //2604:a880:800:10::5f:9001
    //45.55.134.13
 
    private static let runner_path  = "runner/"
    private static let user_path  = "user/"
    static let facebookURLScheme = "fb284815255373672"
    
    
    class URLS {
         }
        let SINGLE_HEADER = ["Content-Type":"application/json"]
 
    
    
    class Parameters : NSObject{
        
        static let shared = Parameters()
        let requestHasFailed = "Request has failed,Please check your network connection"

        //Global
        let active = "active"
        let box_content = "box_content"
        let box_content_ar = "box_content_ar"
        let category = "category"
        let code = "code"
        let country = "country"
        let date_add = "date_add"
        let date_upd = "date_upd"
        let desc  = "description"
        let desc_ar  = "descriptionAr"
        let dimensions = "dimensions"
        let highlights = "highlights"
        let highlights_ar = "highlightsAr"
        let id = "id"
        let id_main_category = "id_main_category"
        let id_main_color = "id_main_color"
        let id_manufacturer = "id_manufacturer"
        let id_supplier = "id_supplier"
        let main_category = "main_category"
        let main_category_ar = "main_category_ar"
        let main_color = "main_color"
        let main_image = "main_image"
        let main_material = "main_material"
        let main_material_ar = "main_material_ar"
        let manufacturer = "manufacturer"
        let manufacturer_ar = "manufacturer_ar"
        let name = "name"
        let name_ar = "nameAr"
        let new_code = "new_code"
        let on_sale = "on_sale"
        let out_of_stock = "out_of_stock"
        let price = "price"
        let quantity = "quantity"
        let rate = "rate"
        let reduction_from = "reduction_from"
        let reduction_percent = "reduction_percent"
        let reduction_price = "reduction_price"
        let reduction_to = "reduction_to"
        let warranty = "warranty"
        let weight = "weight"
        let wholesale_price = "wholesale_price"
        let image = "image"
        let id_parent = "id_parent"
        let id_product = "id_product"
        let id_image = "id_image"
        let image_url = "image_url"
        let is_new = "is_new"
        
        
        private override init() {}
        
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

