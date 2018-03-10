//
//  CategoryTableCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectionImg: UIImageView!
    
      var isSelectedCell : Bool = false
    
    var delegate : FilterTableView?
    
//    var iSelected = false   {
//        didSet{
//            print(iSelected)
//            selectionImg?.image = iSelected ?  #imageLiteral(resourceName: "check_box_active_") : #imageLiteral(resourceName: "check_box_unactive_")
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//         if selected{
//            selectionImg.image = #imageLiteral(resourceName: "check_box_active_")
//            delegate?.selectionData.brandsID.append(self.tag)
//            
//        }else{
//            selectionImg.image = #imageLiteral(resourceName: "check_box_unactive_")
//            let array = delegate?.selectionData.brandsID
//            print(self.tag)
//            if let index = array?.index(of: self.tag)    {
//                delegate?.selectionData.brandsID.remove(at: index)
//            } else {
//                // not found
//                print("Not found")
//            }
//        }
//    }
    
}
