//
//  ProductCell.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var offerContView: UIViewX!
    @IBOutlet weak var newBadge: UIImageView!
    @IBOutlet weak var offerLbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var price1Lbl: UILabel!
    @IBOutlet weak var price2Lbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        price2Lbl.alpha = 0
        price1Lbl.textColor = Constant.BloodyRed
        offerContView.alpha = 0
        
    }
    
    func configCell(data:Product_Data) {
        offerLbl.text = data.new_code
        productImg.setupApiImage(imagePath:  data.main_image)
        titleLbl.text = data.name
        
        if data.on_sale {
            price1Lbl.strikeIt(text: data.wholesale_price)
            price2Lbl.alpha = 1
            price2Lbl.text = data.reduction_price
            offerLbl.text = "\(data.reduction_percent)%"
            offerContView.alpha = 1
            
        }
        
        if data.is_new {
            newBadge.alpha = 1
        }else {
            newBadge.alpha = 0
        }
        
        
    }
    
}

