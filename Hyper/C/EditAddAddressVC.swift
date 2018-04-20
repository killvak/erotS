//
//  EditAddAddressVC.swift
//  Hyper
//
//  Created by Killva on 4/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MapKit

class EditAddAddressVC: UIViewController  {
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var countryTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    @IBOutlet weak var areaTF: SkyFloatingLabelTextField!
    @IBOutlet weak var streetTF: SkyFloatingLabelTextField!
    @IBOutlet weak var buldingNumTF: SkyFloatingLabelTextField!
    @IBOutlet weak var floorNumTF: SkyFloatingLabelTextField!
    @IBOutlet weak var apartmentNumTF: SkyFloatingLabelTextField!
    @IBOutlet weak var nearetLandMarkTF: SkyFloatingLabelTextField!
    @IBOutlet weak var locationTypeTF: SkyFloatingLabelTextField!
    @IBOutlet weak var preferedTimeDelTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumTF: SkyFloatingLabelTextField!
    @IBOutlet weak var landLineNumTF: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingNotesTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mapView: MKMapView!

    fileprivate var myPickerView: UIPickerView!

    fileprivate var locationManager: CLLocationManager!
    fileprivate var isCurrentLocation: Bool = false
    fileprivate var annotation: MKAnnotation!


    var cities : [Cities] =  []
    var selectedCity : Cities = .Zakazik{
        didSet {
            areas =   selectedCity.getDistricts()
//            print(selectedCity)
//            print(selectedCity.getDistricts())
            if areas.count >= 1 {
                self.areaTF.alpha = 1
                self.areaTF.isUserInteractionEnabled = true
            }else {
                self.areaTF.text = ""
                self.areaTF.alpha = 0.4
                self.areaTF.isUserInteractionEnabled = false
            }
        }
    }
    var lat : Double = 0
    var lng : Double = 0
    var areas : [District] = []
    
    @IBAction func backBtnhandler(_ sender: UIButton) {
        self.dismissPushedView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
 pickUp(cityTF)
        pickUp(areaTF)
        self.hideKeyboardWhenTappedAround()
        
        var  lastCity  : Cities = .Zakazik
         for x in 0...lastCity.rawValue{
            let value = Cities(rawValue: x)!
            cities.append(value)
        }
        self.areaTF.text = ""
        self.areaTF.alpha = 0.4
        self.areaTF.isUserInteractionEnabled = false
       
        
        mapView.delegate = self
currentLocationButtonAction()
        //        let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.plain, target: self, action: #selector(currentLocationButtonAction(_:)))

    }

 
    
    @IBAction func saveDataBtnHandler(_ sender: UIButton) {
        
//     currentLocationButtonAction()
        checkTfValidation()
    }
    
    func checkTfValidation() {
        
        
        guard let fName = firstNameTF.text , !fName.isBlankOrLessThan(3) else {
            self.showCustomeApiErrorSms(err: L0A.Name_has_toContain_AtLeast_3_.stringValue())
            return
        }
        guard let lastName = lastNameTF.text , !lastName.isBlankOrLessThan(3) else {
            self.showCustomeApiErrorSms(err: L0A.Name_has_toContain_AtLeast_3_.stringValue())
            return
        }
        guard let mobileNum = mobileNumTF.text , !mobileNum.isBlankOrLessThan(12) , mobileNum.ispriceValue else {
            self.showCustomeApiErrorSms(err: L0A.invalid_Mobile_Number.stringValue())
            return
        }
        guard let city = cityTF.text , !city.isBlankOrLessThan(2) else {
            self.showCustomeApiErrorSms(err: L0A.City_Fields_is_Required.stringValue())
             return
        }
        print(areas)
        if    areas.count >= 1 , !(areaTF.text?.isBlankOrLessThan(3))!   {
            
        }else {
            if areas.count == 0 {
                
            }else {
                self.showCustomeApiErrorSms(err: L0A.Area_Fields_is_Required.stringValue())
                return
            }
        }
         guard let street = streetTF.text , !street.isBlankOrLessThan(2) else {
            self.showCustomeApiErrorSms(err: L0A.Street_Fields_is_Required.stringValue())
            return
        }
        
        guard let locationType = locationTypeTF.text , !locationType.isBlankOrLessThan(2) else {
            self.showCustomeApiErrorSms(err: L0A.Location_Fields_is_Required.stringValue())
            return
        }
        
        var parm : [String : Any] = [
        "landline": self.landLineNumTF.text ?? "",
        "preferred_time": self.preferedTimeDelTF.text ?? "",
        "floor_num": 0,
        "landmark": self.nearetLandMarkTF.text ?? "",
        "city_name": city,
        "latitude": self.lat,
        "location_type": self.locationTypeTF.text ?? "",
        "street_name": self.streetTF.text ?? "",
        "country_name": self.countryTF.text ?? "",
        "notes": self.shippingNotesTF.text ?? "",
        "user_id": ad.getUserID(),
        "address_id": "9",
        "longitude": self.lng,
        "building_num": 0,
        "phone_id": "string",
        "area_name": self.areaTF.text ?? "",
        "mobile": self.mobileNumTF.text ?? ""

        ]
        if let apartN = self.apartmentNumTF.text , !apartN.isBlankOrLessThan(1) , let apartNum = Int(apartN) {
            parm["apartment_num"] = apartNum
         }
        
     
        Post_Requests().addAddress_Request(parms: parm, success: {
            
            
        }) { (err ) in
            self.showApiErrorSms(err: err )
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}






//MARK: PickerView
extension EditAddAddressVC :   UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,CLLocationManagerDelegate {
    
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        textField.delegate = self
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector( doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector( cancelClick))
        toolBar.setItems([  spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }

    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityTF.isEditing ?  cities.count : areas.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if cityTF.isEditing  {
//            selectedCity = cities[row]
            return cities[row].stringValue()
        } else {
                return  areas[row].stringValue()
            }

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if cityTF.isEditing  {
        self.cityTF.text = cities[row].stringValue()
            selectedCity = cities[row]
        }else {
            print(selectedCity)
            print(areas)
            guard areas.count - 1 >= row else {
                 return
            }
            self.areaTF.text = areas[row].stringValue()
        }
    }
    //MARK:- TextFiled Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.pickUp(cityTF)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  textField == cityTF ,  textField.text == "" {
            textField.text = cities[0].stringValue()
            selectedCity = cities[0]
        }  else  if  textField == areaTF ,  textField.text == "" {
            print(selectedCity)
            print(areas)
            guard areas.count - 1 >= 1 else {
                return
            }
                    textField.text = areas[0].stringValue()
        
                }
    }
   @objc func doneClick() {
//        cityTF.resignFirstResponder()
//    self.view.endEditing(true)
    self.dismissKeyBoard()
    }
//    @objc func cancelClick() {
//        cityTF.resignFirstResponder()
//    }
   
    
}


extension EditAddAddressVC : MKMapViewDelegate  {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isCurrentLocation {
            return
        }
        
        isCurrentLocation = false
        
        guard let location = locations.last else {
            
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        self.lat = location.coordinate.latitude
        self.lng = location.coordinate.longitude
        getAddressFromLatLon(location.coordinate.latitude,  location.coordinate.longitude) { (address ) in
            
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location.coordinate
        pointAnnotation.title = ""
        mapView.addAnnotation(pointAnnotation)
    }
    
    @objc func currentLocationButtonAction(_ sender: UIBarButtonItem? = nil ) {
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager?.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            isCurrentLocation = true
        }
    }
    
    func getAddressFromLatLon(_ lat : Double , _ long : Double , completed : @escaping (String)->()) {
        //(self.navigationItem.rightBarButtonItem?.customView as! UIButton).setImage(UIImage(named: "gps_green.png"), for: .normal)\
        DispatchQueue.main.async {
            ad.isLoading()
        }
        let geoCoder = CLGeocoder()
        
        let loc: CLLocation = CLLocation(latitude:lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(loc, completionHandler: { [weak self ] (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            var addressString : String = ""
            if let locationDict = placeMark?.addressDictionary {
//                print(locationDict)

                // Location name
                if let locationName = locationDict["Name"] as? String {
                    print(locationName, terminator: "")
                    addressString = addressString + locationName + ","
                    
                }
                
                // Street address
                if let street = locationDict["Thoroughfare"] as? String {
                    print(street, terminator: "")
                    addressString = addressString + street + ","
                    self?.streetTF.text = street
                }
                
                // City
                if let city = locationDict["City"] as? String {
                    print(city, terminator: "")
                    addressString = addressString + city + ","
//                    self?.cityTF.text = city
                }
                
                // Zip code
                if let zip = locationDict["ZIP"] as? String {
                    print(zip, terminator: "")
                    addressString = addressString + zip + ","
                }
                
                // Country
                if let country = locationDict["Country"] as? String {
                    print(country, terminator: "")
                    addressString = addressString + country + ","
                    self?.countryTF.text = country
                }
            }
            DispatchQueue.main.async {
                ad.killLoading()
//                self?.addressLbl.text = addressString
            }
            completed(addressString)
        })
        
    }
}
