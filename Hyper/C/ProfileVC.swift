//
//  ProfileVC.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController , FilterProtocol {

    @IBOutlet weak var navV: NavigationBarView!
    let filterView : FilterCustomeView  = {
     let vc = FilterCustomeView()
         return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navV.titleS = "Profile View"
        navV.backBtn.addTarget(self , action: #selector(dismissViews), for: .touchUpInside)
//        filterView.emptyViewBtn.addTarget(self, action: #selector(dismissFilterView), for: .touchUpInside)
        filterView.delegate = self
    }
    
    
    @objc func dismissFilterView() {
        filterView.removeFromSuperview()
    }
    @objc func dismissViews() {

        print("WOOOOW"  )

         filterView.frame = self.view.frame
        self.view.addSubview(filterView)
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

extension ProfileVC  {
    func applyFilterHandler() {
        print("Apply Filter")
         dismissView()
    }
    
    func dismissView(){
        filterView.removeFromSuperview()

        
    }
    
}
