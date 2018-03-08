//
//  CategoryTableCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectionImg: UIImageView!

    
    override var isSelected: Bool {
        didSet {
            selectionImg.image = isSelected ? #imageLiteral(resourceName: "check_box_active_") : #imageLiteral(resourceName: "check_box_unactive_")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
