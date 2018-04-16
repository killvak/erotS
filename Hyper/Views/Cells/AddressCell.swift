//
//  AddressCell.swift
//  Hyper
//
//  Created by Killva on 3/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var favImgV: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(data :Address_Model) {
        userNameLbl.text = data.userData.first_name + " " + data.userData.last_name
        addressLbl.text = data.fullAddress == "" ? "unknown" :  data.fullAddress
        phoneNumberLbl.text = data.phoneData.mobile == "" ? "unknown" :  data.phoneData.mobile
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
