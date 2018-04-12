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
    
     var brandsData : [Cat_Brand_Data] = []
    var categoriesData : [Cat_Brand_Data] = []
    var promotionsData :[Promotions_Data] = []
}
class Categories_Specefications_Data {
    
    var cat_name = ""
    var cat_id : Int?
    var productsData : [Product_Data] = []
    var categoriesData : [Cat_Brand_Data] = []
 }

//class Brands_Data {
//
//    private var _active : Int!
//      private var _code : String!
//       private var _date_add : String!
//    private var _date_upd : String!
//
//    private var _name : String!
//    private var _name_ar : String!
//     private var _id : Int!
//    private var _image : String!
//
//    var active  : Bool {
//        return  _active == 1 ?  false :   true
//    }
//     var code : String {return _code}
//     var date_add : String {return _date_add}
//    var date_upd : String {return _date_upd}
//
//    var name : String {
//        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
//    }
//    var image : String {
//        return  Constant.images_Url +   _image
//    }
//    var  id : Int {return _id}
//
//    init(_ jsonData : JSON) {
//        self._active = jsonData[Constant.parameters.active].intValue
//         self._code = jsonData[Constant.parameters.code].stringValue
//         self._date_add = jsonData[Constant.parameters.date_add].stringValue
//        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
//         self._name = jsonData[Constant.parameters.name].stringValue
//        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
//
//        self._id = jsonData[Constant.parameters.id].intValue
//        self._image = jsonData[Constant.parameters.image].stringValue
//
//
//    }
//
//
//}

class Cat_Brand_Data {
    
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
        return  Constant.images_Url +   _image
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
    
     private var _date_add : String!
    private var _date_upd : String!
    private var _id : Int!
    private var ـid_image : Int!

     private var _image : String!
    private var _id_product : Int!
    private var _price : Double!
    private var _quantity : Int!

  
     var date_add : String {return _date_add }
    var date_upd : String {return _date_upd }
    var  id : Int {return _id }
    var  id_image : Int {return ـid_image }

   
    var image : String {
        return  Constant.images_Url +   _image
    }
    var   id_product : Int {return _id_product }
    
    var   quantity : Int {return _quantity }

    init(_ jsonData : JSON) {
         self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._id = jsonData[Constant.parameters.id].intValue
        self.ـid_image = jsonData[Constant.parameters.id_image].intValue
        self._id_product = jsonData[Constant.parameters.id_product].intValue

        self._image = jsonData[Constant.parameters.image_url].stringValue
        
        
    }
    
    
}


class Address_Model {
    
    private var _area_name : String!
    private var _location_type : String!
    private var _landmark : String!

    private var _floor_num : Int!
    private var _building_num : Int!
    
    private var _phone_id : String!
    private var _street_name : String!
    private var _latitude : Int!
    private var _preferred_time : String!
    private var _address_id : String!
    private var _city_name : String!
    private var _mobile : String!
    
    private var _longitude : Int!
    private var _notes : String!
    private var _landline : String!
    private var _country_name : String!

    private var _apartment_num : Int!
    private var _user_id : String!
 
    var area_name : String {return _area_name }
    var location_type : String {return _location_type }
    var landmark : String {return _landmark }
    var floor_num : Int {return _floor_num }
    var building_num : Int {return _building_num }
    var phone_id : String {return _phone_id }
    var street_name : String {return _street_name }
    var latitude : Int {return _latitude }
    var preferred_time : String {return _preferred_time }
    var address_id: String {return _address_id }
    var city_name : String {return _city_name }
    var mobile : String {return _mobile }
    var longitude : Int {return _longitude }
    var notes : String {return _notes }
    var landline : String {return _landline }
    var country_name : String {return _country_name }
    var apartment_num : Int {return _apartment_num }
    var user_id : String {return _user_id }

    init(_ jsonData : JSON) {
        self._area_name = jsonData[Constant.parameters.area_name].stringValue
        self._location_type = jsonData[Constant.parameters.location_type].stringValue
        self._landmark = jsonData[Constant.parameters.landmark].stringValue
        self._floor_num = jsonData[Constant.parameters.floor_num].intValue
        self._building_num = jsonData[Constant.parameters.building_num].intValue
        self._phone_id = jsonData[Constant.parameters.phone_id].stringValue
        self._street_name = jsonData[Constant.parameters.street_name].stringValue
        self._latitude = jsonData[Constant.parameters.latitude].intValue
        self._preferred_time = jsonData[Constant.parameters.preferred_time].stringValue
        self._address_id = jsonData[Constant.parameters.address_id].stringValue
        self._city_name = jsonData[Constant.parameters.city_name].stringValue
        self._mobile = jsonData[Constant.parameters.mobile].stringValue
        self._longitude = jsonData[Constant.parameters.longitude].intValue
        self._notes = jsonData[Constant.parameters.notes].stringValue
        self._landline = jsonData[Constant.parameters.landline].stringValue
        self._country_name = jsonData[Constant.parameters.country_name].stringValue
        self._apartment_num = jsonData[Constant.parameters.apartment_num].intValue
        self._user_id = jsonData[Constant.parameters.user_id].stringValue

 
 
 
        
    }
    
    
}





