//
//  ReviewCell.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
