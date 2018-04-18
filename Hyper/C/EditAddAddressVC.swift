//
//  EditAddAddressVC.swift
//  Hyper
//
//  Created by Killva on 4/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import McPicker

class EditAddAddressVC: UIViewController {
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var countryTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        McPicker.show(data: [["Kevin", "Lauren", "Kibby", "Stella"]]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self?.cityTF.text = name
            }
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
