//
//  AddressCell.swift
//  Hyper
//
//  Created by Killva on 3/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
