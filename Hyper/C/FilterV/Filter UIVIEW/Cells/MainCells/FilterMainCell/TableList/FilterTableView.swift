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
    
    //MARK: OutLets
    @IBOutlet weak var tableView: UITableView!

    
    //MARK: Vars
    weak var FilterMainCell : FilterMainCell?
    var data = [Filter_Listed_Data]()
    var listType : FilterTypes?
//    var selectedIndexs =  [Int]()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
  
    
    var selectionData = SelectedCells()
    var selectedIndex : [Int] = []{
        didSet {
            print("that;s the current filter \( FilterViewController.filterParameters)")

            let indexType = listType == FilterTypes.brands ? filterParameters.brands.rawValue : filterParameters.cats.rawValue
            var iDS = [Int]()
            for i in selectedIndex {
                iDS.append(data[i].id)
            }
            if  listType == FilterTypes.brands {
               
                 FilterViewController.filterParameters[indexType] = iDS

            }else {
               FilterViewController.filterParameters[indexType] = iDS

            }   

            print("that;s the current filter \( FilterViewController.filterParameters)")
        }
    }
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableCell", for: indexPath) as! CategoryTableCell
        cell.tag = indexPath.row
        cell.delegate = self
        print("\(indexPath.row) isSelected : \(cell.isSelectedCell)")
        cell.selectionImg.image = nil
        cell.configCell(data: data[indexPath.row])
        if let index = selectedIndex.index(of: indexPath.item)    {
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
//        selectedIndex.append(indexPath.item)
        print("\(tableView.indexPathsForSelectedRows)")

        if  selectedIndex.contains(indexPath.row) {
            selectedIndex =  selectedIndex.filter { $0 != indexPath.row }
        }else {
            selectedIndex.append(indexPath.row)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableCell else { return }
        print("Before \(tableView.indexPathsForSelectedRows)")

         tableView.deselectRow(at: indexPath, animated: true)
        print("After \(tableView.indexPathsForSelectedRows)")
        cell.selectionImg.image = #imageLiteral(resourceName: "check_box_unactive_")
        cell.isSelectedCell = false
        
        if  selectedIndex.contains(indexPath.row) {
             selectedIndex =  selectedIndex.filter { $0 != indexPath.row }
        }else {
             selectedIndex.append(indexPath.row)
        }
        
    }
}
