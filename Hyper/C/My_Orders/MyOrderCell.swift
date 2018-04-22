//
//  MyOrderCell.swift
//  Hyper
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

enum OrderStatusType : Int {
    case in_Processing = 1
    case Confirmed
    case Shipped
    case Delivered
   case Canceled
    
    func stringValue() ->String {
        switch self {
        case .in_Processing :
            return L0A.in_Processing.stringValue()
        case .Confirmed :
            return L0A.confirmed.stringValue()

        case .Shipped :
            return L0A.shipped.stringValue()

        case .Delivered :
            return L0A.delivered.stringValue()
        case .Canceled :
            return L0A.canceled.stringValue()

        }
    }
 }
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

    
    func configCell(data : OrderDetails_Model  ) {
        
         Order_serialLbl.text = data.name
        dateLbl.text = data.date_add
        stateLbl.text = data.current_state.stringValue()
        
        setupCellByType(type: data.current_state)
        
        
    }
    
   private func setupCellByType(type : OrderStatusType ) {
       
        switch type {
            
        case .in_Processing:
            setupColoring(color: Constant.BloodyRed, imgName: "ic_inprocessing_", statusTitle: L0A.in_Processing.stringValue())
        case .Shipped:
            setupColoring(color: .weirdOrange, imgName: "ic_shipped_", statusTitle: L0A.shipped.stringValue())
            
        case .Delivered:
            setupColoring(color: .deafultGreen, imgName: "ic_deliverd_", statusTitle: L0A.delivered.stringValue())
            
        case .Canceled:
            setupColoring(color: .darkText, imgName: "ic_canceled_", statusTitle: L0A.canceled.stringValue())
        case .Confirmed:
            setupColoring(color: .defaultPurple, imgName: "ic_confirmed_", statusTitle: L0A.confirmed.stringValue())
        }

        
    }
    
    func setupColoring(color : UIColor,imgName : String,statusTitle : String) {
        self.imageV.image = UIImage(named: imgName)
        self.stateLbl.textColor = color
        self.stateLbl.text = statusTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
