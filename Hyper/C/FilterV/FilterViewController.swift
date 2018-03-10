//
//  FilterViewController.swift
//  Hyper
//
//  Created by admin on 3/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    let filterView : FilterCustomeView  = {
        let vc = FilterCustomeView()
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.delegate = self

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
        print("Apply Filter")
        dismissFilterView()
    }
    
    func dismissFilterView(){
        filterView.removeFromSuperview()
        
        
    }
    
}
