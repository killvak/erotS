//
//  RegisterVC.swift
//  Hyper
//
//  Created by Killva on 4/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterVC: UIViewController {
    
    @IBOutlet weak var firstNameTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var passTxtF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var maleImgV: UIImageView!
    @IBOutlet weak var femaleImgV: UIImageView!
    @IBOutlet weak var checkPolicyImgV: UIImageView!
    
    
    var genderType = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func backBtnHandler(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func maleGenderHandler(_ sender: UIButton) {
        
        guard sender.imageView?.image != #imageLiteral(resourceName: "btn_radio_active_") else {
            return
        }
        genderType = 1
        maleImgV.image = #imageLiteral(resourceName: "btn_radio_active_")
        femaleImgV.image = #imageLiteral(resourceName: "btn_radio_unactive_")

    }
    @IBAction func femaleGenderHandler(_ sender: UIButton) {
        
        guard sender.imageView?.image != #imageLiteral(resourceName: "btn_radio_active_") else {
            return
        }
        genderType = 0
         femaleImgV.image = #imageLiteral(resourceName: "btn_radio_active_")
        maleImgV.image = #imageLiteral(resourceName: "btn_radio_unactive_")

    }
    @IBAction func policyBtnHandler(_ sender: UIButton) {
       
        
        if sender.tag  == 0{
            self.checkPolicyImgV.image = #imageLiteral(resourceName: "check_box_active_")
             sender.tag  = 1
        }else {
             self.checkPolicyImgV.image = #imageLiteral(resourceName: "check_box_unactive_")
             sender.tag  = 0
        }
    }
    
    @IBAction func registerBtnHandler(_ sender: UIButton) {
        validateRegisteration()
        ad.killLoading()
    }
    
    func validateRegisteration(){
        ad.isLoading()
        guard let firstN = firstNameTxtF.text , firstN.count >= 3 else {
            firstNameTxtF.errorMessage = "Invalid First Name"
            firstNameTxtF.becomeFirstResponder()
            return
        }
        firstNameTxtF.errorColor = .green
        guard let lastN = lastNameTxtF.text ,lastN.count >= 3  else {
            lastNameTxtF.errorMessage = "Invalid Last Name"
            lastNameTxtF.becomeFirstResponder()
            return
        }
        lastNameTxtF.errorColor = .green
        guard let email = emailTxtF.text ,email.isEmail else {
            emailTxtF.errorMessage = "Invalid Email Format"
            emailTxtF.becomeFirstResponder()
            return
        }
        emailTxtF.errorColor = .green
        guard let pass  = passTxtF.text ,pass.isValidPassword  else {
            passTxtF.errorMessage = "Invalid Password"
            passTxtF.becomeFirstResponder()
            return
        }
        passTxtF.errorColor = .green
        
        let parm = [
            "email": email,
            "first_name": firstN,
            "last_name": lastN,
            "password": pass,
            "gender": genderType == 1 ? "male":"female",
            //            "birthday": "string"
        ]
        
        Post_Requests().social_Login(postType: .signup_User, parms: parm, completion: { (rData ) in
            
            DispatchQueue.main.async {
                ad.saveUserLogginData(email: rData.email , photoUrl:nil, uid: rData.id, name: rData.fullName)
                ad.reload()
                ad.killLoading()
                
            }
        }) { (err ) in
            self.showApiErrorSms(err: err )
            ad.killLoading()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


