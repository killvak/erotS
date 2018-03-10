//
//  FilterTableView.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
class  SelectedCells : NSObject {
    
    var priceRange  : CountableClosedRange<Int>?
    var brandsID : [Int] = []
    
}
class FilterTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
  
    
    var selectionData = SelectedCells()
    var selectedIndex : [IndexPath] = []
     private func commonUnit() {
        
        let view = Bundle.main.loadNibNamed("FilterTableView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryTableCell", bundle: nil), forCellReuseIdentifier: "CategoryTableCell")
    
    }
    
}
extension FilterTableView : UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableCell", for: indexPath) as! CategoryTableCell
        cell.tag = indexPath.row
        cell.delegate = self
        print("\(indexPath.row) isSelected : \(cell.isSelectedCell)")
        if let index = selectedIndex.index(of: indexPath)    {
            cell.selectionImg.image = #imageLiteral(resourceName: "check_box_active_")

        } else {
            // not found
            cell.selectionImg.image = #imageLiteral(resourceName: "check_box_unactive_")
        }

 
//        cell.selectionImg.image =   #imageLiteral(resourceName: "check_box_unactive_")
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableCell else { return }
     print(selectionData.brandsID.count)
        print("\(selectionData.brandsID)")
         cell.selectionImg.image = #imageLiteral(resourceName: "check_box_active_")
        cell.isSelectedCell = true
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedIndex.append(indexPath)
        print("\(tableView.indexPathsForSelectedRows)")

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableCell else { return }
        print("Before \(tableView.indexPathsForSelectedRows)")

         tableView.deselectRow(at: indexPath, animated: true)
        print("After \(tableView.indexPathsForSelectedRows)")
        cell.selectionImg.image = #imageLiteral(resourceName: "check_box_unactive_")
        cell.isSelectedCell = false
        
    }
}
