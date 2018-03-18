//
//  SearchControllerVC.swift
//  Hyper
//
//  Created by Killva on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol SearchControllerProtocol {
    
    func fetchData()
}
class SearchControllerVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyTableViewPHV: UIView!
    
    var data = [CatBrand_Data]()
    var searchResult = [CatBrand_Data]()
    var search:String=""

    var recentSearchData = [RecentSearchHistory]() {
        didSet {
            guard searchBar.text == "" else {
                emptyTableViewPHV.alpha = 1

                return
            }
            if recentSearchData.count >= 1 {
                emptyTableViewPHV.alpha = 0
            }else {
                emptyTableViewPHV.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        data = Constant.catBrand
        searchBar.delegate = self
        recentSearchData = Constant.recentSearch
        
        hideKeyboardWhenTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissViewHandler(_ sender: UIButton) {
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil    )
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
}



extension SearchControllerVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard searchBar.text != ""  else {
            
            return recentSearchData.count
        }
        guard searchResult.count < 0 else {
            return searchResult.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        guard searchBar.text != "" else {
            cell.imageView?.image = #imageLiteral(resourceName: "ic_bar_search_")
            cell.textLabel?.text = recentSearchData[indexPath.row].name
            cell.textLabel?.textColor = Constant.BloodyRed
            return cell
        }
        guard searchResult.count < 0 else {
            cell.textLabel?.text = searchResult[indexPath.row].name
            cell.imageView?.image = #imageLiteral(resourceName: "ic_search_unactive_")
            return cell
        }
        cell.textLabel?.text = data[indexPath.row].name
        cell.imageView?.image = #imageLiteral(resourceName: "ic_search_unactive_")
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.data[indexPath.row]
        
        Constant.recentSearch.append(RecentSearchHistory(name: data.name, id: data.id, type: data.type))
    }
    
    
    
    
}


extension SearchControllerVC :   UISearchBarDelegate {
    
    
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
        if searchResult.count >= 1 {
            emptyTableViewPHV.alpha = 0
        }else {
            emptyTableViewPHV.alpha = 1
        }
        
        self.tableView.reloadData()
    }
    
}
