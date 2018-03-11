//
//  BrandsVC.swift
//  Hyper
//
//  Created by Killva on 3/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BrandsVC: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataTitleLbl: UILabel!
    
    var data = [Cat_Brand_Data]()
    
    var isCat = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pTitle = isCat ? L0A.All_Categories.stringValue() : L0A.All_Brands.stringValue()
        setupNav()
        dataTitleLbl?.text = pTitle

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



extension BrandsVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.textColor = Constant.FontColorGray
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard isCat else {
//
//            return
//        }
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SelectedBrandVC") as! SelectedBrandVC
//        self.navigationController?.pushViewController(vc, animated: true)
//
        guard !isCat else {
            
            navCategoryToProductsList(catID: data[indexPath.row].id, pageNum: 1, pageTitle: self.data[indexPath.row].name)
            
            return
        }
        navBrandToProductsList(brandID: data[indexPath.row].id, pageNum: 1, pageTitle: data[indexPath.row].name)
    }
    
    
    
}
