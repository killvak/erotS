//
//  MyCartCell.swift
//  Hyper
//
//  Created by Killva on 4/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

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

    weak var mycartVC : MyCartVC?
    var data:Product_Data!
    var quantity = 1 {
        didSet {
            quantityLbl?.text = "\(quantity)"
 
            guard  let data = CoreDataClass.someEntityExistsInCartCD(id: data?.id ?? 0 ) else  {
                print("Shit happens in core data : MyCartCell☯️ ")
                return
             }
            mycartVC?.data[removeBtn.tag].newQuantity = quantity
            data.quantity = Int16(quantity)
            data.id = Int16(data.id)
            CoreDataClass.saveContext()
//            mycartVC?.fetchCartData()

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.subQuanBtn.alpha = quantity == 1 ? 0.5 : 1
    }
    
    func configCell(data:Product_Data) {
        self.data = data
      self.quantity =  Int(self.quantityLbl.text!) ?? 1
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
         mycartVC?.totalPrice += data.price
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
  mycartVC?.totalPrice -= data.price
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
