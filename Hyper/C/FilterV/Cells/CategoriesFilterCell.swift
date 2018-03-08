//
//  CategoryFilterCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CategoriesFilterCell: UICollectionViewCell {

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
             //check_box_unactive_
            //check_box_active_
     }

}
