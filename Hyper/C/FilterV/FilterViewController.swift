//
//  FilterViewController.swift
//  Hyper
//
//  Created by admin on 3/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

enum filterParameters : String {
    
    case min_price = "min_price"
    case max_price = "max_price"
    case cats = "cats"
    case brands = "brands"
    case colors = "colors"
    
}
protocol  FilterViewControllerDelegate : class  {
    func fetchData(data : ProductFull_Data)
 }

class FilterViewController: UIViewController {

    
    //MARK: HardCoded OutLets
   lazy var filterView : FilterCustomeView  = {
        let vc = FilterCustomeView()
     vc.filterData = filterData
        return vc
    }()
   
    //MARK : Vars
   static  var filterParameters : [String:Any] = [:]
    var filterData = Filter_Data()

    weak var delegate : FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func openFilterView() {
        print("WOOOOW"  )
        filterView.frame = self.view.frame
        self.view.addSubview(filterView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FilterViewController : FilterProtocol  {
    func applyFilterHandler() {
        
        self.getSearchFilterData(parms: FilterViewController.filterParameters, page: 1, completed: { [unowned self](rData) in
        
            self.delegate?.fetchData(data: rData)
        }) { (err ) in
            
            
        }
           dismissFilterView()
    }
    
 
    
    func dismissFilterView(){
        filterView.removeFromSuperview()
        
        
    }
    
}
