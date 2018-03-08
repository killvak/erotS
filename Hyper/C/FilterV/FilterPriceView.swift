//
//  FilterPriceView.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterPriceView: UIView {
    
    @IBOutlet weak var sliderV: RangeSeekSlider!

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
    
    
    private func commonUnit() {
        
        let view = Bundle.main.loadNibNamed("FilterPriceView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        
        self.sliderV.minDistance = sliderV.maxValue * 0.16
        sliderV.numberFormatter.positiveSuffix =  L0S.Currency.stringValue()

    }
    
}
