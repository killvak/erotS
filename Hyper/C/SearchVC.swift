//
//  SearchVC.swift
//  Hyper
//
//  Created by Killva on 3/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["TV & Home Theater","Radio","Air Cond","Fan","Washing Machine"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchTxt.delegate = self
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeIt)))
    }
 
    @objc func swipeIt() {
        
        let vc = BrandsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//extension SearchVC : UITextFieldDelegate {
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//    }
//
//}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.backgroundColor = .clear 
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = Constant.FontColorGray
        cell.selectionStyle = .none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ProductsListVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
