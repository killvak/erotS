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
    
    @IBOutlet weak var sliderV: RangeSeekSlider! {
        didSet {
            sliderV?.delegate = self
          }
    }
    //MARK: Vars
    weak var FilterMainCell : FilterMainCell?
    private var initOnce = false
    var minPrice = 0
    var maxPrice = 0{
        didSet {
            guard !initOnce else {
                print("value Change \(sliderV.maxValue)")
                return
            }
            commonUnit()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        commonUnit()
    }
    
    
    
    
    
    
    private func commonUnit() {
        initOnce = true
        let view = Bundle.main.loadNibNamed("FilterPriceView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        self.sliderV.minValue = CGFloat(minPrice)
        self.sliderV.maxValue = CGFloat(maxPrice)
        self.sliderV.selectedMaxValue = CGFloat(maxPrice) * 0.9
        self.sliderV.selectedMinValue = CGFloat(maxPrice) * 0.1
        self.sliderV.minDistance = sliderV.maxValue * 0.16
        
        self.minPrice = Int(sliderV.selectedMinValue)
        self.maxPrice = Int(sliderV.selectedMaxValue)
        sliderV.numberFormatter.positiveSuffix =  L0S.Currency.stringValue()
 
        
    }
 
    
}



extension FilterPriceView: RangeSeekSliderDelegate {
    
    //    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
    //        if slider === sliderV {
    //            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
    //        }
    //    }
    
//    func didStartTouches(in slider: RangeSeekSlider) {
//        print("did start touches")
//    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
//        print("did end touches")
//        print("Standard slider updated. Min Value: \(slider.selectedMinValue) Max Value: \(slider.maxValue)")
        self.minPrice = Int(slider.selectedMinValue)
        self.maxPrice = Int(slider.selectedMaxValue)
        
         FilterViewController.filterParameters[filterParameters.min_price.rawValue] = minPrice
         FilterViewController.filterParameters[filterParameters.max_price.rawValue] = maxPrice
        print("that;s the current filter \( FilterViewController.filterParameters)")

     }
}
