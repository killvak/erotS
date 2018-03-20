//
//  FilterCustomeView.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol  FilterProtocol : class  {
    func dismissFilterView()
    func applyFilterHandler()
}

class FilterCustomeView: UIView , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var emptyViewBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTableHeaderView: UIView!
    @IBOutlet weak var filterViewBottomCons: NSLayoutConstraint!
    //MARK : Vars
    weak var delegate : FilterProtocol?
     var filterData = Filter_Data()
      var filterParameters : [String:Any] = [:]

     override init(frame: CGRect) {
        super.init(frame: frame)
        commonUnit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonUnit()
    }
    
    
    
    
    private func commonUnit() {
        self.alpha = 1
        let view = Bundle.main.loadNibNamed("FilterCustomeView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 46
//        tableView.register(UINib(nibName: "FilterMainCell", bundle: nil), forCellReuseIdentifier: "FilterMainCell")
registerCEll()
        self.filterView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggingFilterView(_:))))
        
    }
    
    
   @objc func draggingFilterView(_ gestureRecognizer : UIPanGestureRecognizer) {
    
    
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {

        let translation = gestureRecognizer.translation(in: self)
        // note: 'view' is optional and need to be unwrapped

        let y = gestureRecognizer.view!.frame.origin.y
        let maxY = UIScreen.main.bounds.height * 0.5

//         guard y >= maxY else {
//            UIView.animate(withDuration: 0.4, animations: {
//               self.filterView.center.y = UIScreen.main.bounds.maxY * 2
//                self.layoutIfNeeded()
//            }) { (_) in
//                self.delegate?.dismissFilterView()
//            }
//
//            return
//
//        }
        let y2 = gestureRecognizer.view!.frame.origin.y

        let shit = self.bounds.height * 0.55
        guard y2 <=  shit  else {
//            UIView.animate(withDuration: 0.4, animations: {
//                self.filterView.center.y = UIScreen.main.bounds.maxY * 2
//                self.layoutIfNeeded()
//            }) { (_) in
//            print("gestureRecognizer.view!.center.y \(y ) \n maxY : \(maxY) y2:\(y2) shit: \(shit) ")
//
////            print("⎲ Removed")
                self.dismissFilterView()
//            }
            return
        }
         let x1 = self.filterView.bounds.origin.y
        let x2 =  self.filterView.bounds.maxY
        let x3 = x1 - x2
        print("🤪self.frame.maxY \(x1)\n 😇self.filterView..frame.maxY \(x2) \n  🤩distance\(x3)")
         gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x , y: gestureRecognizer.view!.center.y + translation.y)

        gestureRecognizer.setTranslation(CGPoint.zero, in: self)
     }
    
    if gestureRecognizer.state == .ended{
        let y2 = gestureRecognizer.view!.frame.origin.y
        
        let shit = self.bounds.height * 0.55
        guard y2 <=  shit  else {
            print("⎖⍹✐")
//            print(" y2:\(y2) shit: \(shit) ")
   self.dismissFilterView()
             return
        }
        let h = self.bounds.height - self.filterView.bounds.height
        let sss = self.bounds.height * 0.54
        let point = CGPoint(x: gestureRecognizer.view!.center.x , y: sss)
        self.filterView.center = point
//        print("⚠︎  ♾")
//        print(" sss:\(sss)   ")

        
    }
//    print("------------------------------")
    }
    
    
    @IBAction func dismissHandler(_ sender: UIButton) {
       
       dismissFilterView()
    }
    
    func dismissFilterView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.filterView.center =  CGPoint(x: self.center.x , y: self.center.y * 4)
            self.alpha = 0
            self.layoutIfNeeded()
        }) { (_) in
             self.delegate?.dismissFilterView()
            self.alpha = 1
        }
    }
    
    @IBAction func applyFilterHandler(_ sender: UIButton) {
//        self.delegate?.applyFilterHandler(parm: FilterCustomeView.filterParameters)
        
      
        self.delegate?.applyFilterHandler()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.listOf.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterMainCell", for: indexPath) as! FilterMainCell
////        let data = filterData.listOf[indexPath.row]
//        cell.filterCustomeV = self
//        cell.setupContainerView(viewType: filterData,indexPath.row)
        var cell : FilterMainCell!
        switch indexPath.row {
        case 0:
          return   createEmailCell(indexPath: indexPath)
        case 1:
           return createEmailCell1(indexPath: indexPath)
        case 2:
           return createEmailCell2(indexPath: indexPath)
        default:
            break
        }
            return cell
        
    }
    func createEmailCell(indexPath: IndexPath) -> FilterMainCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath) as! FilterMainCell
        //        let data = filterData.listOf[indexPath.row]
        cell.filterCustomeV = self
        cell.setupContainerView(viewType: filterData,indexPath.row)
        return cell
    }
    func createEmailCell1(indexPath: IndexPath) -> FilterMainCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "2", for: indexPath) as! FilterMainCell
        //        let data = filterData.listOf[indexPath.row]
        cell.filterCustomeV = self
        cell.setupContainerView(viewType: filterData,indexPath.row)
        return cell
    }
    func createEmailCell2(indexPath: IndexPath) -> FilterMainCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "3", for: indexPath) as! FilterMainCell
        //        let data = filterData.listOf[indexPath.row]
        cell.filterCustomeV = self
        cell.setupContainerView(viewType: filterData,indexPath.row)
        return cell
    }
    
    func registerCEll() {
        tableView.register(UINib(nibName: "FilterMainCell", bundle: nil), forCellReuseIdentifier: "1")
        tableView.register(UINib(nibName: "FilterMainCell", bundle: nil), forCellReuseIdentifier: "2")
        tableView.register(UINib(nibName: "FilterMainCell", bundle: nil), forCellReuseIdentifier: "3")

    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil 
    }
}

extension FilterCustomeView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1
 
            guard let cell = tableView.cellForRow(at: indexPath) as? FilterMainCell else { return }
            cell.selecteds()
            // 4
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // 5
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
     
    }
}
