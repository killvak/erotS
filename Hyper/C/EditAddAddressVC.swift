//
//  EditAddAddressVC.swift
//  Hyper
//
//  Created by Killva on 4/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

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
    
    fileprivate var myPickerView: UIPickerView!

    var cities : [Cities] =  []
    var areas = ["sasdasdsa"]
    
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
    }

 
    
    @IBAction func saveDataBtnHandler(_ sender: UIButton) {
        
     
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
extension EditAddAddressVC :   UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
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
        return cityTF.isEditing ? cities[row].stringValue() : areas[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if cityTF.isEditing  {
        self.cityTF.text = cities[row].stringValue()
        }else {
            self.areaTF.text = areas[row]
        }
    }
    //MARK:- TextFiled Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.pickUp(cityTF)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  textField == cityTF ,  textField.text == "" {
            textField.text = cities[0].stringValue()
            
        }  else  if  textField == areaTF ,  textField.text == "" {
                    textField.text = areas[0]
        
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
