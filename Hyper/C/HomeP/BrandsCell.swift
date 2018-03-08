//
//  BrandsCell.swift
//  Hyper
//
//  Created by Killva on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BrandsCell: UICollectionViewCell {
    
    @IBOutlet weak var produuctImgV: UIImageView!
    
    func configCell(data : Brands_Data) {
        
        produuctImgV.setupApiImage(imagePath: data.image)
        
    }
    
    
}
