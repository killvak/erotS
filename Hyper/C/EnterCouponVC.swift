//
//  EnterCouponVC.swift
//  Hyper
//
//  Created by admin on 4/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol  EnterCouponVCProtocol : class  {
    
    func applyFilter(codeNum : String)

}


class EnterCouponVC: UIViewController {

    @IBOutlet weak var typeCouponTxtF: SkyFloatingLabelTextField!
    
    weak var delegate : EnterCouponVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func applyBtnHandler(_ sender: UIButtonX) {
        
        guard let code = typeCouponTxtF.text , code.isBlankOrLessThan(4) else
        {
            self.showCustomeApiErrorSms(err: L0A.RequiredـField.stringValue())
        return
    }
        delegate?.applyFilter(codeNum: code)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelBtnHandler(_ sender: UIButtonX) {
        
        
        
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
