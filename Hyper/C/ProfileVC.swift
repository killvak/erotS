//
//  ProfileVC.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ProfileVC: FilterViewController {

    @IBOutlet weak var navV: NavigationBarView!
   
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navV.titleS = "Profile View"
        navV.backBtn.addTarget(self , action: #selector(openFilterView), for: .touchUpInside)
//        filterView.emptyViewBtn.addTarget(self, action: #selector(dismissFilterView), for: .touchUpInside)
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

