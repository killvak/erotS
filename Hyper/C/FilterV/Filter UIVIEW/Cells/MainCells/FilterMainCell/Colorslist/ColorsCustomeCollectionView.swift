//
//  ColorsCustomeCollectionView.swift
//  Hyper
//
//  Created by admin on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Foundation

class ColorsCustomeCollectionView: UIView {
   
 
    @IBOutlet weak var collectionView: UICollectionView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Vars
    weak var FilterMainCell : FilterMainCell?
    var selectionData = SelectedCells()
    var selectedIndex : [IndexPath] = []
    var data = [Colors_Data]() {
        didSet {
             commonUnit()
        }
    }
    
    func resetData() {
        self.selectedIndex = []
        self.collectionView.reloadData()
    }
    
    var selectedIndexs = [Int]() {
        didSet {
            var iDS = [Int]()
            for i in selectedIndexs {
                iDS.append(data[i].id)
            }
            FilterViewController.filterParameters[filterParameters.colors.rawValue] = iDS
            print("that;s the current filter \( FilterViewController.filterParameters)")
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonUnit()
    }
    
    
    
    

    
    private func commonUnit() {
        
        let view = Bundle.main.loadNibNamed("ColorsCustomeCollectionView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        collectionView.delegate = self
        collectionView.dataSource = self
         collectionView.register(UINib(nibName: "ColorsSelectorCell", bundle: nil), forCellWithReuseIdentifier: "ColorsSelectorCell")

    }

}



extension ColorsCustomeCollectionView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsSelectorCell", for: indexPath) as! ColorsSelectorCell
        cell.selectedView.alpha = 0
        cell.configCell(data: data[indexPath.row])
        if  selectedIndexs.contains(indexPath.row) {
            cell.isSelectedView(true)
        }else {
            cell.isSelectedView(false)
        }
        return cell

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
 
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorsSelectorCell

        if  selectedIndexs.contains(indexPath.row) {
            cell.isSelectedView(false)
            selectedIndexs =  selectedIndexs.filter { $0 != indexPath.row }
        }else {
            cell.isSelectedView(true)
            selectedIndexs.append(indexPath.row)
        }
      }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//        let cell = collectionView.cellForItem(at: indexPath) as? ColorsSelectorCell
//        cell?.isSelectedView(false)
//
//    }
}
