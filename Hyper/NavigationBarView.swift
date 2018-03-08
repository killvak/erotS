//
//  NavigationBarView.swift
//  Hyper
//
//  Created by admin on 2/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var navTitleLbl: UILabel!
    
    var titleS = "" {
        didSet {
            self.navTitleLbl?.text = titleS
        }
    }
     override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
   
    
    private func commonUnit() {
        
    let view = Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
}
