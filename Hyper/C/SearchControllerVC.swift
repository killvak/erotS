//
//  SearchControllerVC.swift
//  Hyper
//
//  Created by Killva on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol SearchControllerProtocol : class {
    
    func fetchData(data : ProductFull_Data?,catData : Categories_Specefications_Data?)
}
  enum SearchDataType : Int {
    case recent = 0
    case data = 1
    case searchData = 2
}
class SearchControllerVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyTableViewPHV: UIView!
    @IBOutlet weak var clearViewHeight: NSLayoutConstraint!
    
    weak var delegate : SearchControllerProtocol?
    var data = [CatBrand_Data]()
    var searchResult = [CatBrand_Data]()

    var searchType : SearchDataType = .recent {
        didSet {
//                 initTableVPlaceHolder(hideIT: false )
         }
    }
    var recentSearchData = [RecentSearchHistory]() {
        didSet {
            guard searchBar.text == "" else {
                emptyTableViewPHV.alpha = 1

                return
            }
            if recentSearchData.count >= 1 {
                emptyTableViewPHV.alpha = 0
                self.clearViewHeight?.constant = 40
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
        self.clearViewHeight.constant =  recentSearchData.count >= 1 ? 40 : 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissViewHandler(_ sender: UIButton) {
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil    )
    }
    
    @IBAction func clearListBtnHandler(_ sender: UIButton) {
        Constant.recentSearch = []
        self.recentSearchData = []
        self.clearViewHeight.constant = 0
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
            searchType = .recent
            return recentSearchData.count
        }
        guard searchResult.count < 0 else {
            searchType = .searchData
            return searchResult.count
        }
        searchType = .data
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear 
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
        var isData : CatBrand_Data!
        switch searchType {
        case .recent:
            let data = recentSearchData[indexPath.row]
            isData = CatBrand_Data(name:  data.name, id:  data.id, type:  data.type)
            break
        case .data:
            let data = self.data[indexPath.row]
            isData = data
            addToRecentSearch(data: data)

           case .searchData:
            isData = searchResult[indexPath.row]
            addToRecentSearch(data: searchResult[indexPath.row])
          }
        
        switch isData.type {
        case .Category:
             getCatProducts(data: isData)
//        case .subCat :
//             getBrandProducts(data: isData)
//        case .Brand :
//              getBrandProducts(data: isData)
//        case .product :
//             getBrandProducts(data: isData)

         default :    getBrandProducts(data: isData)
        }
     
       
    }
    func getBrandProducts(data : CatBrand_Data) {
        ad.isLoading()
        Get_Requests().brand_By_ID_Request(brandID: data.id, page: 1, completion: { (rData ) in
            DispatchQueue.main.async {
                 ad.killLoading()
                self.delegate?.fetchData(data: rData, catData: nil)
                self.dismiss(animated: true, completion: nil)
             }
            
        }) { (err ) in
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    func getCatProducts(data : CatBrand_Data) {
        ad.isLoading()
        Get_Requests().category_By_Id(catID: data.id, page: 1, completion: { (rData ) in
            DispatchQueue.main.async {
                ad.killLoading()
                rData.cat_name = data.name
                self.delegate?.fetchData(data: nil, catData: rData)
                self.dismiss(animated: true, completion: nil)
            }
            
        }) { (err ) in
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    
    func addToRecentSearch(data : CatBrand_Data  ) {
        var isNewVar = true
        for x in Constant.recentSearch {
            if x.name == data.name {
                isNewVar = false
                return
            }
        }
        guard isNewVar else { return }
        Constant.recentSearch.append(RecentSearchHistory(name:  data.name, id:  data.id, type:  data.type))
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
        ad.isLoading()
        Post_Requests().postSearch(query: searchBar.text , min_price: nil, max_price: nil, cats: nil, brands: nil, colors: nil, page: 1, completion: { [weak self  ] (rData ) in
            
            DispatchQueue.main.async {
                ad.killLoading()
//                self?.data =   rData
                self?.searchResult = rData
                self?.tableView.reloadData()
            }
            
        }) { (err ) in
            DispatchQueue.main.async {
                ad.killLoading()
                self.showApiErrorSms(err: err )
            }
            
        }
        
        
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
           initTableVPlaceHolder(hideIT: true )
        }else {
            initTableVPlaceHolder(hideIT: false )
        }
        
        self.tableView.reloadData()
    }
    
    func initTableVPlaceHolder(hideIT : Bool ) {
        
        guard searchBar.text != "" else {
            emptyTableViewPHV.alpha = recentSearchData.count >= 1 ? 0 : 1
            return
        }
        if hideIT , recentSearchData.count >= 1 {
            
        }else {
            emptyTableViewPHV.alpha = hideIT ? 0 : 1
         }
        
    }
    
}
