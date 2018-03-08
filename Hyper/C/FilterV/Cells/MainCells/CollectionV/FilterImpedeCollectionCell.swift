//
//  FilterImpedeCollectionCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FilterImpedeCollectionCell: UITableViewCell {
    
    @IBOutlet weak var dropDownimg: UIImageView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var filterTitle: UILabel!
    //    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CategoryFilterCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesFilterCell") 
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func showTableV(_ sender: UIButton) {
        
        if tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 80
            }, completion: { (_) in
                
            })
        }else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 0
            }, completion: { (_) in
                
            })
            
        }
        
    }
    
    
    func selecteds() {
        
        if self.tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 220
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

extension FilterImpedeCollectionCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 90
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesFilterCell", for: indexPath) as! CategoriesFilterCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 30)
    }
    
    
    
}
