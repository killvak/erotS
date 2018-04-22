//
//  OrderDetailsCell.swift
//  Hyper
//
//  Created by admin on 4/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class OrderDetailsCell: UITableViewCell {
    
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var price1Lbl: UILabel!
    @IBOutlet weak var price2Lbl: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var ratingBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        price2Lbl.alpha = 0
        price1Lbl.textColor = Constant.BloodyRed
 
    }
    


    func configCell(data:Order_Cart_DetailsModel) {
        
        productImg.setupApiImage(imagePath:  data.image )
//        ratingView.value = CGFloat(data.rate)
        productTitleLbl.text = data.name
        quantity.text = "\(data.quantity)"
        
//        if data.on_sale {
//            price1Lbl.strikeIt(text: data.wholesale_price)
//            price2Lbl.alpha = 1
//            price2Lbl.text = data.reduction_price
//            
//        }else {
//            price1Lbl.text = "\(data.price) L.E"
//        }
        
    }
    
    
 
    
    
}
