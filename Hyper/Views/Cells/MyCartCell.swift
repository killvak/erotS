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
    @IBOutlet weak var addQuanBtn: UIButton!
    @IBOutlet weak var subQuanBtn: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!

    
    var quantity = 1 {
        didSet {
            quantityLbl?.text = "\(quantity)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        quantityLbl?.text = "1"
        self.subQuanBtn.alpha = quantity == 1 ? 0.5 : 1
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
    
    @IBAction func addQuanBtnHandler(_ sender: UIButton) {
        guard let quant = Int(quantityLbl.text!) else {
            return
        }
        
        if quant >= 1 {
            self.subQuanBtn.alpha = 1
            self.subQuanBtn.isEnabled = true
            quantity += 1
        }else {
          self.subQuanBtn.alpha = 0.5
            self.subQuanBtn.isEnabled = false
        }
    }
    
    
    @IBAction func subQuanBtnHandler(_ sender: UIButton) {
        guard let quant = Int(quantityLbl.text!) else {
            return
        }
        
        if quant > 1 {
            quantity -= 1
            self.subQuanBtn.alpha = quantity <= 1 ? 0.5 : 1
            self.subQuanBtn.isEnabled = quantity <= 1 ? false : true

        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
