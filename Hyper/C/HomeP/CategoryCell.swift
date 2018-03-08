//
//  CategoryCell.swift
//  Hyper
//
//  Created by Killva on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import AlamofireImage


class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    
    func configCell(data : Categories_Data) {
        
        title.text = data.name
        print(data.image)
        productImg.setupApiImage(imagePath:  data.image)
    }
    
    
    
}
