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
    
    var data = [Cat_Brand_Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchTxt.delegate = self
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeIt)))
    }
 
    func getData() {
        ad.isLoading()
        let isCat = true
        Get_Requests().all_Data_about(categories: isCat, brands: !isCat, page: 1, completion: { [unowned self ] (rData) in
            
            DispatchQueue.main.async {
                
                ad.killLoading()
                
                 self.data = rData
               self.tableView.reloadData()
            }
            
        }) { [weak self ](err )  in
             DispatchQueue.main.async {
            ad.killLoading()
            self?.showApiErrorSms(err: err )
            }
        }
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
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.textColor = Constant.FontColorGray
        cell.selectionStyle = .none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ProductsListVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
