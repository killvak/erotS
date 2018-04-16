//
//  EditProfileVC.swift
//  Hyper
//
//  Created by Killva on 4/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileVC: UIViewController {

    @IBOutlet weak var firstNameTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTxtF: SkyFloatingLabelTextField!

    @IBOutlet weak var oldPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var newPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmNewPassword: SkyFloatingLabelTextField!
     let ALERT = L0A.Warning.stringValue()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissBtnAct(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func checkTextF()-> Bool {
        var parm  : [String : Any] = [:]
        if  let firstN = firstNameTxtF.text   {
            if firstN.count <= 3 {
            firstNameTxtF.errorMessage = "Invalid First Name"
            firstNameTxtF.becomeFirstResponder()
                return false
                
            }else {
             parm["first_name"] =  firstN
                firstNameTxtF.errorColor = .green

            }
        }
  //        firstNameTxtF.errorColor = .green
        if let lastN = lastNameTxtF.text    {
            if lastN.count <= 3  {
            lastNameTxtF.errorMessage = "Invalid Last Name"
            lastNameTxtF.becomeFirstResponder()
             return false
            }else {
                parm["last_name"] =  lastN
                lastNameTxtF.errorColor = .green

            }
        }
         if let email = emailTxtF.text ,email.isEmail   {
            if !email.isEmail {
                emailTxtF.errorMessage = "Invalid Email Format"
                emailTxtF.becomeFirstResponder()
                return false
            }else {
                parm["email"] =  email
                emailTxtF.errorColor = .green

             }

        }
        emailTxtF.errorColor = .green
        parm["user_id"] =  ad.getUserID
        if let oldPass = oldPassword.text  ,  checkTextValidation(oldPass) {
            oldPassword.errorColor = .green

        guard let newPass = newPassword.text , checkTextValidation(newPass) else {
            showPassWarning()
            return false
        }
        guard let confirmPass = confirmNewPassword.text , checkTextValidation(confirmPass) else {
            showPassWarning()
            return false
        }
        guard newPass == confirmPass else {
            self.view.showSimpleAlert(ALERT, L0A.Password_Doesnot_Match.stringValue(), .warning)
            return false
        }
        //        guard newPass == oldPass else {
        //            self.view.showSimpleAlert(ALERT,  Constants.LanguagesDict().getLocalizedTitle("New password can't be the same as the old password"), .warning)
        //            return false
        //        }
        
            newPassword.errorColor = .green
            confirmNewPassword.errorColor = .green

      
        parm["password"] =  newPass
        }else if !oldPassword.text!.isBlank {
            showPassWarning()
        }
        Post_Requests().social_Login(postType: .edit_Profile , parms: parm, completion: { (rData ) in
            
            DispatchQueue.main.async {
                ad.saveUserLogginData(email: rData.email , photoUrl:nil, uid: rData.id, name: rData.fullName)
                ad.reload()
                ad.killLoading()
                
            }
        }) { (err ) in
            self.showApiErrorSms(err: err )
            ad.killLoading()
        }
        return true
    }
    @IBAction func sendData(_ sender: UIButton) {
        
        
        ad.isLoading()
        guard  checkTextF() else {
            ad.killLoading()
            return
        }
      
    
    }
    
    func showPassWarning() {
        
        self.view.showSimpleAlert(ALERT, L0A.Password_has_to_contain_more_than_characters.stringValue(), .warning)
        
    }
    func checkTextValidation(_ text : String) -> Bool  {
        guard text.count >= 8  else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
}

