//
//  ColorsSelectorCell.swift
//  Hyper
//
//  Created by admin on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ColorsSelectorCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIViewX!
    @IBOutlet weak var selectedView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.backgroundColor = UIColor(hex: "091B82B")
    }
    func isSelectedView(_ isIT : Bool ) {
        
        selectedView.alpha = isIT ? 1 : 0
        
    }
    
    
    func configCell(data : Colors_Data) {
        print(data.code)
        colorView.backgroundColor = UIColor(hex: "0\(data.code)")
        
    }
    
    
    
}
