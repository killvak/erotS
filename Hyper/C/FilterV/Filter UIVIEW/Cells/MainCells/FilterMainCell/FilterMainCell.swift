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
    
    //MARK : Vars
    var filterData =  [Filter_Listed_Data]()
    weak var filterCustomeV  :FilterCustomeView?
//    var filterParameters : [String:Any] = [:] {
//        didSet {
//            self.filterCustomeV?.filterParameters = filterParameters
//            print("that;s the current filter \(filterParameters)")
//        }
//    }
//    var priceParms : [String:Any] = [:] {
//        didSet {
//            filterParameters.merge(priceParms.lazy.map { ($0.key, $0.value) }) { (current, _) in current }
//
//            print("that;s the current filter \(filterParameters)")
//        }
//    }
//    var brandParm : [String:Any] = [:] {
//        didSet {
//            filterParameters.merge(brandParm.lazy.map { ($0.key, $0.value) }) { (current, _) in current }
//            print("that;s the current filter \(filterParameters)")
//        }
//    }
//    var catParm : [String:Any] = [:] {
//        didSet {
//            filterParameters.merge(catParm.lazy.map { ($0.key, $0.value) }) { (current, _) in current }
//            print("that;s the current filter \(filterParameters)")
//        }
//    }
    
    var listType : FilterTypes = .brands
    var mainData = Filter_Data()
    private var expandableViewHeight : CGFloat = 80
    
    //MARK: HardCoded OutLets
    lazy var  priceView : FilterPriceView = {
        let vc = FilterPriceView()
        vc.clipsToBounds = true
        vc.minPrice = mainData.minPrice ?? 0
        vc.maxPrice = mainData.maxPrice ?? 1000
        vc.filterCustomeV = filterCustomeV
        vc.translatesAutoresizingMaskIntoConstraints = false
        return vc 
    }()
    lazy var  tableVView : FilterTableView = {
        let vc = FilterTableView()
        vc.clipsToBounds = true
        vc.data = filterData
        vc.listType = listType
        vc.FilterMainCell = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    lazy var  colorsCollectionV : ColorsCustomeCollectionView = {
        let vc = ColorsCustomeCollectionView()
        vc.clipsToBounds = true
        vc.FilterMainCell = self 
          vc.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func setupContainerView(viewType : Filter_Data ,_ index : Int ) {
        /*
         case brands = 0
         case categories = 1
         case colors = 2
         case price = 3
         */
        mainData = viewType
        self.filterTitle.text = viewType.listOf[index].getFilterName()
        switch viewType.listOf[index].rawValue {
            
        case 0  :
            listType = .brands
            self.filterData = viewType.brands
            var cacHeight : CGFloat = CGFloat(viewType.brands.count * 53)
            cacHeight = cacHeight <= 280 ? cacHeight : 280
            setupContainerViewType(view: tableVView,height:cacHeight   )
            
        case 1  :
            listType = .categories
            self.filterData = viewType.categories
            var cacHeight : CGFloat = CGFloat(viewType.categories.count * 53)
            cacHeight = cacHeight <= 280 ? cacHeight : 280
             setupContainerViewType(view: tableVView,height:cacHeight)
            
        case 2 :
            
            setupContainerViewType(view: colorsCollectionV,height:60)
        case 3 : setupContainerViewType(view: priceView,height:80)
        default : break
            
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
