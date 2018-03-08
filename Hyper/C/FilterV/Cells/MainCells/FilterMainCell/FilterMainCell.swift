//
//  FilterPriceTableCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterMainCell: UITableViewCell {

    @IBOutlet weak var dropDownimg: UIImageView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var filterTitle: UILabel!
     @IBOutlet weak var expandableViewContainer: UIView!
    
    private var expandableViewHeight : CGFloat = 80
    let priceView : FilterPriceView = {
        let vc = FilterPriceView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        return vc 
    }()
    let tableVView : FilterTableView = {
        let vc = FilterTableView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
     }
    
    
    func setupContainerView(viewType : Int ) {
        
        switch viewType {
        case 0 : setupContainerViewType(view: tableVView,height:280)
        case 1 : setupContainerViewType(view: priceView,height:80)
        case 2 : setupContainerViewType(view: priceView,height:80)
        default : setupContainerViewType(view: tableVView,height:280)
        }
    }
    private func setupContainerViewType(view : UIView,height: CGFloat) {
        expandableViewHeight = height
        expandableViewContainer.clipsToBounds = true
        self.expandableViewContainer.addSubview(view)
        
        view.topAnchor.constraint(equalTo: expandableViewContainer.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: expandableViewContainer.bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: expandableViewContainer.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: expandableViewContainer.trailingAnchor, constant: 0).isActive = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
 
    func selecteds() {
        
        if self.tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = self.expandableViewHeight
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
