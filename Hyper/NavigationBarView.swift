//
//  NavigationBarView.swift
//  Hyper
//
//  Created by admin on 2/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    
    
    @IBOutlet weak var containerVIew: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
    private func commonUnit() {
        
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(containerVIew)
        containerVIew.frame = self.bounds
        containerVIew.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        
    }
    
}
