//
//  FilterPriceTableCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterPriceTableCell: UITableViewCell {

    @IBOutlet weak var dropDownimg: UIImageView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var sliderV: RangeSeekSlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sliderV.minDistance = sliderV.maxValue * 0.16
        
//          sliderV.numberFormatter.positivePrefix = "$"
        sliderV.numberFormatter.positiveSuffix =  L0S.Currency.stringValue()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
 
    func selecteds() {
        
        if self.tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 80
                self.layoutIfNeeded()
            }, completion: { (_) in
                
            })
            UIView.transition(with: dropDownimg, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.dropDownimg.image = #imageLiteral(resourceName: "ic_arrow_up_")
            }) { (true) in
                
            }
        }else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 0
                self.layoutIfNeeded()
            }, completion: { (_) in
                
            })
            UIView.transition(with: dropDownimg, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.dropDownimg.image = #imageLiteral(resourceName: "ic_arrow_dowen_")
                
            }) { (true) in
                
            }
        }
        
    }
    
}
