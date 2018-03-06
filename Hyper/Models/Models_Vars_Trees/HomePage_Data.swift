//
//  Models.swift
//  Hyper
//
//  Created by admin on 3/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON


class HomePage_Data {
    
     var brandsData : [Brands_Data] = []
    var categoriesData : [Categories_Data] = []
    var promotionsData :[Promotions_Data] = []
}

class Brands_Data {
    
    private var _active : Int!
      private var _code : String!
       private var _date_add : String!
    private var _date_upd : String!
  
    private var _name : String!
    private var _name_ar : String!
     private var _id : Int!
    private var _image : String!

    var active  : Bool {
        return  _active == 1 ?  false :   true
    }
     var code : String {return _code}
     var date_add : String {return _date_add}
    var date_upd : String {return _date_upd}
    
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    var image : String {
        return   _image
    }
    var  id : Int {return _id}
    
    init(_ jsonData : JSON) {
        self._active = jsonData[Constant.parameters.active].intValue
         self._code = jsonData[Constant.parameters.code].stringValue
         self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
         self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._image = jsonData[Constant.parameters.image].stringValue

 
    }
    
    
}

class Categories_Data {
    
    private var _active : Int!
    private var _code : String!
    private var _date_add : String!
    private var _date_upd : String!
    
    private var _name : String!
    private var _name_ar : String!
    private var _id : Int!
    private var _image : String!
    private var _id_parent : Int!

    var active  : Bool {
        return  _active == 1 ?  false :   true
    }
    var code : String {return _code}
    var date_add : String {return _date_add}
    var date_upd : String {return _date_upd}
    
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    var image : String {
        return   _image
    }
    var  id : Int {return _id}
    var  id_Parent : Int {return _id_parent}

    init(_ jsonData : JSON) {
        self._active = jsonData[Constant.parameters.active].intValue
        self._code = jsonData[Constant.parameters.code].stringValue
        self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._image = jsonData[Constant.parameters.image].stringValue
        self._id_parent = jsonData[Constant.parameters.id_parent].intValue

        
    }
    
    
}


class Promotions_Data {
    
}

