//
//  MyCartCell.swift
//  Hyper
//
//  Created by Killva on 4/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MyCartCell: UITableViewCell {

     @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var price1Lbl: UILabel!
    @IBOutlet weak var price2Lbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(data:Product_Data) {

        productImg.setupApiImage(imagePath:  data.main_image)
        titleLbl.text = data.name
        
        if data.on_sale {
            price1Lbl.strikeIt(text: data.wholesale_price)
            price2Lbl.alpha = 1
            price2Lbl.text = data.reduction_price
 
        }else {
            price1Lbl.text = "\(data.price) L.E"
        }
        
      }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
