//
//  CatBrand_Data.swift
//  Hyper
//
//  Created by Killva on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

enum CatBrandType : Int {
    case Category = 0
    case Brand = 1
}

class CatBrand_Data {
    
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


