//
//  SearchVC.swift
//  Hyper
//
//  Created by Killva on 3/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var data = [Cat_Brand_Data]()
      var names : [String] = []
    var searchMainData = [String]()
    var searchResult = [Cat_Brand_Data]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        searchTxt.delegate = self
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeIt)))
        getData()
        searchBar.delegate = self

    }
 
    func getData() {
        ad.isLoading()
        let isCat = true
        Get_Requests().all_Data_about(categories: isCat, brands: !isCat, page: 1, completion: { [unowned self ] (rData) in
            
            DispatchQueue.main.async {
                
                ad.killLoading()
                
                 self.data = rData
               self.tableView.reloadData()
                for x in rData {
                    self.names.append(x.name)
                }
                self.searchMainData = self.names
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

        if let searchString = searchBar?.text, searchString.count > 0 {
            
  
            return searchResult.count
            
        }
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.backgroundColor = .clear
        if let searchString = searchBar?.text, searchString.count > 0 {
           
            cell.textLabel?.text = searchResult[indexPath.row].name
            
            
        } else {
        cell.textLabel?.text = data[indexPath.row].name
        }
        cell.textLabel?.textColor = Constant.FontColorGray
        cell.selectionStyle = .none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
navCategoryToProductsList(catID: data[indexPath.row].id, pageNum: 1, pageTitle: self.data[indexPath.row].name)
    }
    
    
    
}


//https://stackoverflow.com/questions/46007260/ios-11-customise-search-bar-in-navigation-bar/46010398
extension SearchVC :   UISearchBarDelegate {

    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        searchBar.resignFirstResponder()
         self.view.endEditing(true)
    }



    // MARK: - Searchbar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // perform a search by reloading the tableView
        
        searchBar.resignFirstResponder()
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // reset the data source
        
        searchBar.text = ""
        
        tableView?.reloadData()
        
    }
    
 
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        // user began entering text into search bar
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        // keyboard was resigned or user clicked a different textfield
        openSearchVC()
        searchBar.resignFirstResponder()
     
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchResult = data.filter({ (text) -> Bool in
            let tmp : NSString = text.name as NSString
            //            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        //        filtered = data.filter({ (text) -> Bool in
        //            let tmp: NSString = text as NSString
        //            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
        //            return range.location != NSNotFound
        //        })

        
        self.tableView.reloadData()
    }
    
}


extension SearchVC : SearchControllerProtocol {
    
    func fetchData(data: ProductFull_Data?, catData: Categories_Specefications_Data?) {
     
        searchDidSelectResponse(data: data, catData: catData)
     }
}


