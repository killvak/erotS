//
//  Models.swift
//  Hyper
//
//  Created by admin on 3/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON


class ItemDetails_Data {
    
    var brandID : Int?
    var productsData :  Product_Data?
    
    var relatedProducts : [Product_Data] = []
    
}

class ProductFull_Data {
    var brandID : Int?
    var sub_Cat_ID : Int?
      var _count : Int?
    var productList = [Product_Data]()
    var filterData = Filter_Data()
}

//filter
class Filter_Data {
    
    var brands = [Filter_Listed_Data]()
    var categories = [Filter_Listed_Data]()
  var colors = [Colors_Data]()
    
    var maxPrice : Int?
    var minPrice : Int?
    
    var listOf : [FilterTypes] {
        var countiT = [FilterTypes]()
        if brands.count >= 1 {
            countiT.append(.brands)
        }
         if categories.count >= 1 {
            countiT.append(.categories)
         }
        if colors.count >= 1 {
            countiT.append(.colors)
        }
        if maxPrice != nil , maxPrice != minPrice {
            countiT.append(.price)
        }
         return countiT
    }
}
enum FilterTypes : Int {
    case brands = 0
    case categories = 1
    case colors = 2
    case price = 3
    func getFilterName() -> String {
        switch self {
        case .brands:
            return L0A.Brands.stringValue()
        case .categories:
            return L0A.Categories.stringValue()
        case .colors:
            return L0A.Colors.stringValue()
        case .price :
            return L0A.price.stringValue()
        }
    }
}
class Product_Data {
    
    private var _active : Int!
    private var _box_content : String!
    private var _box_content_ar : String!
    private var _category : String!
    private var _code : String!
        
    private  var _colors : [Colors_Data] = []
    private  var _images : [Images_Data] = []
    private var _reviews : [Reviews_Data] = []
    private var _country : String!
    private var _date_add : String!
    private var _date_upd : String!
    private var _description : String!
    private var _description_ar : String!
    private var _dimensions : String!
    private var _highlights : String!
    private var _highlights_ar : String!
    
    private var _main_category : String!
    private var _main_category_ar : String!
    private var _main_image : String!
    private var _main_material : String!
    private var _main_material_ar : String!
    private var _manufacturer  : String!
    private var _manufacturer_ar : String!
    private var _name : String!
    private var _name_ar : String!
    private var _new_code : String!
    private var _reduction_from : String!
    private var _reduction_price : String!
    private var _reduction_to : String!
    private var _warranty : String!
    private var _weight : String!
    private var _wholesale_price : String!
    
    private var _id : Int!
    private var _id_main_category : Int!
    private var _id_main_color : Int!
    private var _id_manufacturer : Int!
    private var _id_supplier : Int!
    private var _main_color : Int!
    private var _is_new : Int!
    private var _on_sale : Int!
    private var _out_of_stock : Int!
    private var _price : Int!
    private var _quantity : Int!
    private var _rate : Int!
    private var _reduction_percent : Int!
    
    var  images : [Images_Data]  {
        return _images
    }
    var  colors : [Colors_Data]  {
        return _colors
    }
    var  reviews : [Reviews_Data]  {
        return _reviews
    }
    var active  : Bool {
        return  _active == 1
    }
    var  on_sale  : Bool {
        return  _on_sale == 1
    }
    var  is_new  : Bool {
        return  _is_new == 1
    }
    var  out_of_stock  : Bool {
        return  _out_of_stock == 1
    }
    var boxContent : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _box_content:  _box_content_ar
    }
    var category : String {return _category}
    var code : String {return _code}
    var country : String {return _country}
    var date_add : String {return _date_add}
    var date_upd : String {return _date_upd}
    
    

    var description : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _description :  _description_ar
    }
    var dimensions : String {return _dimensions}
    var highlights : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _highlights :  _highlights_ar
    }
    var main_category : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _main_category :  _main_category_ar
    }
    var main_image : String {
        return  Constant.images_Url +   _main_image
         }
    var main_material : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _main_material :  _main_material_ar
    }
    var manufacturer : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _manufacturer :  _manufacturer_ar
    }
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    var new_code : String {return _new_code}
    var reduction_from : String {return _reduction_from}
    var reduction_price : String {return _reduction_price}
    var reduction_to : String {return _reduction_to}
    var warranty : String {return _warranty}
    var weight : String {return _weight}
    var wholesale_price : String {return _wholesale_price}
    
    
    var  id : Int {return _id}
    var  id_main_category : Int {return _id_main_category}
    var  id_main_color : Int {return _id_main_color}
    var  id_manufacturer : Int {return _id_manufacturer}
    var  id_supplier : Int {return _id_supplier}
    var  main_color : Int {return _main_color}
    
    var  price : Int {return _price}
    var  quantity : Int {return _quantity}
    var  newQuantity : Int {
        set {
            _quantity = newValue
        }
        get {
        return _quantity}
    }

    var  rate : Int {return _rate}
    var  reduction_percent : Int {return _reduction_percent}
    
    init(_ jsonData : JSON) {

        self._active = jsonData[Constant.parameters.active].intValue
        self._box_content = jsonData[Constant.parameters.box_content].stringValue
        self._box_content_ar = jsonData[Constant.parameters.box_content_ar].stringValue
        self._category = jsonData[Constant.parameters.category].stringValue
        self._code = jsonData[Constant.parameters.code].stringValue
        self._country = jsonData[Constant.parameters.country].stringValue
        self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._description = jsonData[Constant.parameters.desc ].stringValue
        self._description_ar = jsonData[Constant.parameters.desc_ar ].stringValue
        
        self._dimensions = jsonData[Constant.parameters.dimensions].stringValue
        self._highlights = jsonData[Constant.parameters.highlights].stringValue
        self._highlights_ar = jsonData[Constant.parameters.highlights_ar].stringValue
        
        self._main_category = jsonData[Constant.parameters.main_category].stringValue
        self._main_category_ar = jsonData[Constant.parameters.main_category_ar].stringValue
        self._main_image = jsonData[Constant.parameters.main_image].stringValue
        self._main_material = jsonData[Constant.parameters.main_material].stringValue
        self._main_material_ar = jsonData[Constant.parameters.main_material_ar].stringValue
        self._manufacturer = jsonData[Constant.parameters.manufacturer].stringValue
        self._manufacturer_ar = jsonData[Constant.parameters.manufacturer_ar].stringValue
        self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        self._new_code = jsonData[Constant.parameters.new_code].stringValue
        self._reduction_from = jsonData[Constant.parameters.reduction_from].stringValue
        self._reduction_price = jsonData[Constant.parameters.reduction_price].stringValue
        self._reduction_to = jsonData[Constant.parameters.reduction_to].stringValue
        self._warranty = jsonData[Constant.parameters.warranty].stringValue
        self._weight = jsonData[Constant.parameters.weight].stringValue
        self._wholesale_price = jsonData[Constant.parameters.wholesale_price].stringValue
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._id_main_category = jsonData[Constant.parameters.id_main_category].intValue
        self._id_main_color = jsonData[Constant.parameters.id_main_color].intValue
        self._id_manufacturer = jsonData[Constant.parameters.id_manufacturer].intValue
        self._id_supplier = jsonData[Constant.parameters.id_supplier].intValue
        self._main_color = jsonData[Constant.parameters.main_color].intValue
        self._on_sale = jsonData[Constant.parameters.on_sale].intValue
        self._is_new = jsonData[Constant.parameters.is_new].intValue
        self._out_of_stock = jsonData[Constant.parameters.out_of_stock].intValue
        self._price = jsonData[Constant.parameters.price].intValue
        self._quantity = jsonData[Constant.parameters.quantity].intValue
        self._rate = jsonData[Constant.parameters.rate].intValue
        self._reduction_percent = jsonData[Constant.parameters.reduction_percent].intValue 

        collection(data: jsonData["colors"])
        getImages(data: jsonData["images"])
        getReviews(data: jsonData["reviews"])
        
     }
    
    private  func collection(data:JSON)
    {
        for ( _ , dic)  in data
        {
            _colors.append(Colors_Data(dic))
        }
    }
    private  func getImages(data:JSON)
    {
        print(data)
        for ( _ , dic)  in data
        {
            _images.append(Images_Data(dic))
        }
    }
    
    private  func getReviews(data:JSON)
    {
        print(data)
        for ( _ , dic)  in data
        {
            _reviews.append(Reviews_Data(dic))
        }
    }
}

class Colors_Data {
    
    private var _color_ID : Int!
    private var _id : Int!
    private var _id_product : Int!
    private var _active : Int
    private var _code : String!
    private var _name : String!
    private var _name_ar : String!

    var color_ID : Int { return _color_ID}
    var id : Int { return _id }
    var id_product : Int { return _id_product}
    var active  : Bool {
        return  _active == 1  
    }
    
    var code : String {
//        _code.removeFirst()
        print(_code)
//        UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        return _code
     }
    
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    
    init(_ jsonData : JSON) {
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._id_product = jsonData[Constant.parameters.id].intValue
        self._active = jsonData["color"][Constant.parameters.active].intValue
        self._code = jsonData["color"][Constant.parameters.code].string
        self._color_ID = jsonData["color"][Constant.parameters.id].intValue
        self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
 
    }
    
}





struct Filter_Listed_Data {
    private var _name : String!
    private var _id : Int!
    private var _name_ar : String!
    
    private var _sum : Int!
    
    var name : String {return  L102Language.currentAppleLanguage() == "ar" ? _name_ar : _name }
    var  id : Int {return _id }
    
    var  sum : Int { return _sum }
    
    
    init(_ jsonData : JSON) {
        self._name = jsonData[Constant.parameters.name].stringValue
        self._id = jsonData[Constant.parameters.id].intValue
        self._sum = jsonData["sum"].intValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        
    }
}
class Reviews_Data {
    
     private var _id : Int!
    private var _id_product : Int!
    private var _active : Int
    private var _code : String!
    private var _name : String!
    private var _name_ar : String!
    
     var id : Int { return _id }
    var id_product : Int { return _id_product}
    var active  : Bool {
        return  _active == 1
    }
    
    var code : String {
        //        _code.removeFirst()
        print(_code)
        return _code
    }
    
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    
    init(_ jsonData : JSON) {
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._id_product = jsonData[Constant.parameters.id].intValue
        self._active = jsonData["color"][Constant.parameters.active].intValue
        self._code = jsonData["color"][Constant.parameters.code].string
         self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        
    }
    
}

class Images_Data {
    
    private var _date_add : String!
    private var _date_upd : String!
    private var _id : Int!
    private var ـid_image : Int!
    
    private var _image : String!
    private var _id_product : Int!
     private var _quantity : Int!
    private var _active : Int!

    var active  : Bool {
        return  _active == 1
   }
    
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
        self._active = jsonData[Constant.parameters.active].intValue

        self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._id = jsonData[Constant.parameters.id].intValue
        self.ـid_image = jsonData[Constant.parameters.id_image].intValue
        self._id_product = jsonData[Constant.parameters.id_product].intValue
        
        self._image = jsonData[Constant.parameters.image_url].stringValue
        
        
    }
    
    
}









class Profile_Details_M {
    private var _birthday : String!
    private var _email : String!
    private var _fav_lan : String!
    private var _fb_token : String!
    private var _first_name : String!
    private var _gender : String!
    private var _google_id : String!
    private var _last_name : String!
    private var _latitude : String!
    private var _longitude : String!

    private var _date_add : String!
    private var _date_upd : String!
    private var _id : Int!
 
    private var _image : String!
      private var _quantity : Int!
    private var _active : Int!
    
    var active  : Bool {
        return  _active == 1
    }
    var birthday : String {return _birthday }

    var date_add : String {return _date_add }
    var date_upd : String {return _date_upd }
    var  id : Int {return _id }

    var email : String {return _email }
    var fav_lan : String {return _fav_lan }
    var fb_token : String {return _fb_token }
    var first_name : String {return _first_name }
    var gender : String {return _gender }
    var google_id : String {return _google_id }
    var last_name : String {return _last_name }
    var latitude : String {return _latitude }
    var longitude : String {return _longitude }

    var fullName : String { return "\(first_name) \(last_name)"}
    var image : String {
        return  Constant.images_Url +   _image
    }
     init(_ jsonData : JSON) {
        self._active = jsonData[Constant.parameters.active].intValue
        self._birthday = jsonData[Constant.parameters.birthday].stringValue
        self._email = jsonData[Constant.parameters.email].stringValue
        self._fav_lan = jsonData[Constant.parameters.fav_lan].stringValue
        self._fb_token = jsonData[Constant.parameters.fb_token].stringValue
        self._first_name = jsonData[Constant.parameters.first_name].stringValue
        self._gender = jsonData[Constant.parameters.gender].stringValue
        self._google_id = jsonData[Constant.parameters.google_id].stringValue
        self._last_name = jsonData[Constant.parameters.last_name].stringValue
        self._latitude = jsonData[Constant.parameters.latitude].stringValue
        self._longitude = jsonData[Constant.parameters.longitude].stringValue

        self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._id = jsonData[Constant.parameters.id].intValue
         self._image = jsonData[Constant.parameters.image_url].stringValue
        
        
    }
    
    
}



class OrderDetails_Model {
    
    private var _active : Int!
    private var _current_stateID : Int!
    
    private var _date_add : String!
    private var _date_upd : String!
    
    private var _name : String!
    private var _name_ar : String!
    private var _id : Int!
    private var _phone : String!
    private var _id_user : Int!
    private var _address : Address_Model?
    private var _cartProduct : [Order_Cart_DetailsModel] = []
    var active  : Bool {
        return  _active == 1 ?  false :   true
    }
    var current_state : OrderStatusType {
        switch _current_stateID {
        case 0:
            return   OrderStatusType.in_Processing
       case 1:
           return   OrderStatusType.Confirmed
        case 2:
           return   OrderStatusType.Shipped
        case 3:
            return  OrderStatusType.Delivered
        default:
           return   OrderStatusType.in_Processing

        }
     }
    var date_add : String {return _date_add}
    var date_upd : String {return _date_upd}
    
    var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _name :  _name_ar
    }
    var phone : String {
        return  _phone
    }
    var cartProduct : [Order_Cart_DetailsModel] {
        
        return _cartProduct
    }
    var  id : Int {return _id}
    var  id_user : Int {return _id_user}
    var address : Address_Model? {
        return _address
    }
    
    init(_ jsonData : JSON) {
        self._active = jsonData[Constant.parameters.active].intValue
        self._current_stateID = jsonData["current_state"]["id"].intValue
        self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._name = jsonData[Constant.parameters.name].stringValue
        self._name_ar = jsonData[Constant.parameters.name_ar].stringValue
        
        self._id = jsonData[Constant.parameters.id].intValue
        self._phone = jsonData["phone"].stringValue
        self._id_user = jsonData["id_user"].intValue
        
        self._address = Address_Model(jsonData["address"])
        
        for x in jsonData["cart"] {
            _cartProduct.append(Order_Cart_DetailsModel(x.1))
        }
    }
    
    
}



class Order_Cart_DetailsModel {
    private var _active : Int!
    private var _date_add : String!
    private var _date_upd : String!
    private var _id : Int!
    private var _id_Order : Int!
    private var _id_product : Int!
    private var _id_user : Int!
    private var _image : String!
    private var _product_name : String!
    private var _product_name_ar : String!
    private var _quantity : Int!
    private var _product_on_sale : Int!
    private var _product_reduction_price : Int!
    private var _product_wholesale_price : Int!
    private var _product_reduction_percent : Double!

    
     var name : String {
        return  L102Language.currentAppleLanguage() != "ar" ?   _product_name :  _product_name_ar
    }
    var active  : Bool {
        return  _active == 1
    }
    var product_reduction_percent :Double { return _product_reduction_percent}

    var product_reduction_price :Int { return _product_reduction_price}
    var product_wholesale_price :Int { return _product_wholesale_price}

    var orderID :Int { return _id_Order}
    var productID :Int { return _id_product}
    var oneSale :Bool { return _product_on_sale == 0 ? false : true }

     var date_add : String {return _date_add }
    var date_upd : String {return _date_upd }
    var  id : Int {return _id }
    var  userID : Int {return _id_user }

    var  quantity : Int {return _quantity }

    
     var image : String {
        return  Constant.images_Url +   _image
    }
    init(_ jsonData : JSON) {
        self._active = jsonData[Constant.parameters.active].intValue
        self._id_Order = jsonData["id_order"].intValue
        self._id_product = jsonData["id_product"].intValue
        self._id_user = jsonData["id_user"].intValue

        
        self._product_name = jsonData["product_name"].stringValue
        self._product_name_ar = jsonData["product_name_ar"].stringValue
        self._quantity = jsonData["quantity"].intValue
         self._date_add = jsonData[Constant.parameters.date_add].stringValue
        self._date_upd = jsonData[Constant.parameters.date_upd].stringValue
        self._id = jsonData[Constant.parameters.id].intValue
        self._image = jsonData["product_image"].stringValue
        self._product_on_sale = jsonData["product_on_sale"].intValue
        self._product_wholesale_price = jsonData["product_wholesale_price"].intValue
        self._product_reduction_price = jsonData["product_reduction_price"].intValue
        self._product_reduction_percent = jsonData["product_reduction_percent"].doubleValue

        
    }
    
    
}
