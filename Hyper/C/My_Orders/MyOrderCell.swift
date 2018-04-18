//
//  MyOrderCell.swift
//  Hyper
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class MyOrderCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var Order_serialLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var favBtn: SwiftyStarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
