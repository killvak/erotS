//
//  CatBrand_Data.swift
//  Hyper
//
//  Created by Killva on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
enum CatBrandType : Int {
    case Category = 0
    case Brand = 1
    case subCat = 2 
    case product = 3
    case none = 4
}

class CatBrand_Data : NSObject{
    
    private var _name : String?
    private var _id : Int!
    private var _type : CatBrandType!
    private var _name_ar : String?

    var name : String {
        return   L102Language.currentAppleLanguage() != "ar" ?   _name ?? _name_ar!  :  _name_ar ?? _name!

    }
    var id : Int { return _id }
    var type : CatBrandType {
        return _type
    }

    init(name : String , id : Int , type : CatBrandType) {
        _name = name
        _id = id
        _type = type
    }
    
        init(_ jsonData : JSON, type : CatBrandType) {
        self._id = jsonData[Constant.parameters.id].intValue
          self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        self._type = type
     }
}




 class RecentSearchHistory {
    
    private var _name : String!
    private var _id : Int!
    private var _type : CatBrandType!
    
    var name : String {
        return _name
    }
    var id : Int { return _id }
    var type : CatBrandType {
        return _type
    }
    
    init(name : String , id : Int , type : CatBrandType) {
        _name = name
        _id = id
        _type = type
    }
}


