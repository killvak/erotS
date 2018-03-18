//
//  ColorsCell.swift
//  Hyper
//
//  Created by Killva on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ColorsCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIViewX!
    @IBOutlet weak var selectedView: UIVisualEffectView!
    
    func isSelectedView(_ isIT : Bool ) {
        
        selectedView.alpha = isIT ? 1 : 0 
        
    }
    
    
    func configCell(data : Colors_Data) {
        print(data.code)
        colorView.backgroundColor = UIColor(hex: "0\(data.code)")
        
    }
    
    
    
}


