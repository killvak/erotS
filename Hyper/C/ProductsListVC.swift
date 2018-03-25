//
//  ProductsListVC.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import UILoadControl



class ProductsListVC: FilterViewController , UITextFieldDelegate {

    @IBOutlet weak var filterContainerView: UIViewX!
    //MARK: Vars
    var pageNum = 2
    var maxPageNum : Int = 20
    var catID : Int?
    var brandID : Int?
   private let cellID = "ProductCell"
    var fullData = ProductFull_Data() {
        didSet {
            filterData = fullData.filterData
            data = fullData.productList
            self.collectionView?.reloadData()
            if filterData.listOf.count >= 1 {
                self.filterContainerView?.alpha = 1
            }
            self.brandID = fullData.brandID
            guard data.count > 4  else { return }
            self.collectionView?.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .top, animated: true)

        }
    }
     var data : [Product_Data] = [] {
        didSet {
            numberOfItemsLbl?.text = "\(data.count) Item"
           //            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];

        }
    }
    var lastContentOffset: CGFloat = 0
var pageTitleAddress = ""
    var canLoadMore = true
    //MARK: OutLets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfItemsLbl: UILabel!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var filterContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productMapAddressLbl: UILabel!
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
 numberOfItemsLbl?.text = "\(data.count) Item"
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.delegate = self
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        productMapAddressLbl.text = pageTitleAddress == "" ? title ?? "" : pageTitleAddress
        searchTxt.delegate = self
        if filterData.listOf.count == 0 {
            self.filterContainerView.alpha = 0
        }
         setupLoadMore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        openSearchVC()
        searchTxt.resignFirstResponder()
        return false
    }
    
    @IBAction func filterhandler(_ sender: UIButton) {
        filterView.delegate = self

        self.openFilterView()
        
        
 
    }
    
    
    @IBAction func backBtnHandler(_ sender: UIButton) {
        
   self.navigationController?.popViewController(animated: true)
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




extension ProductsListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProductCell
        cell.configCell(data: data[indexPath.row])
        cell.backgroundColor = .clear
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self , action: #selector(showBtmMenu(_:)), for: .touchUpInside)
        cell.newBadge.alpha = indexPath.row % 2 == 0  ? 1 : 0
        return cell
    }

    @objc func showBtmMenu(_ sender : UIButton) {
        showMoreMenu(data: data[sender.tag])
    }
 

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = self.data[indexPath.row]
        
        self.getItemDetails(id: data.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.view.frame.width * 0.47
        let height = width * 1.4529411765
        return CGSize(width: width, height: height)
    }
 
 
}


extension ProductsListVC {
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
 
        let x : IndexPath = IndexPath(row: 0, section: 0)
        guard !collectionView.indexPathsForVisibleItems.contains(x)  else { return }
    
    if targetContentOffset.pointee.y < scrollView.contentOffset.y {
    // it's going up
    UIView.animate(withDuration: 0.4, animations: {
    self.filterContainerViewHeight.constant = 64
    self.view.layoutIfNeeded()
    })
    } else {
    // it's going down
    UIView.animate(withDuration: 0.4, animations: {
    self.filterContainerViewHeight.constant = 0
    self.view.layoutIfNeeded()
    })
    }
    
    }
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    
}

extension ProductsListVC : FilterViewControllerDelegate {
 
    func fetchData(data: ProductFull_Data) {
        print(data)
        self.fullData = data
    }
}
extension ProductsListVC : SearchControllerProtocol {
 
 
    func fetchData(data: ProductFull_Data?, catData: Categories_Specefications_Data?) {
        guard let dataaa = data else {
            guard let dataa = catData else { return }
            let sb = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SelectedBrandVC") as! SelectedBrandVC
            vc.mainData = dataa
            vc.title = dataa.cat_name
            self.navigationController?.pushViewController(vc, animated: true)
            return }
        self.fullData = dataaa
        self.data = dataaa.productList
        self.collectionView.reloadData()
    }
}

extension ProductsListVC {
 
        func resetHomePageData() {
            self.pageNum = 1
            getData(_pageNum: 1)
        }
        
        func setupLoadMore() {
            
            collectionView.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
            collectionView.loadControl?.heightLimit = 100.0 //The default is 80.0
        }
        
        //update loadControl when user scrolls de tableView
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            guard self.pageNum < maxPageNum , pageNum != maxPageNum else { return }
            scrollView.loadControl?.update()
        }
        
        //load more tableView data
        @objc  func loadMore(sender: AnyObject?) {
            self.pageNum = self.pageNum + 1
            getData(_pageNum: self.pageNum)
        }
        
    func getData(_pageNum : Int) {
        
        if let catID = self.catID  {
            getCatProducts(id: catID, pageNum: _pageNum)
        }else if let brandID = self.brandID {
            getBrandProducts(id: brandID, pageNum: _pageNum)
        }else {
            print("No ID avalaible")
        }
    }
    func getBrandProducts(id : Int, pageNum : Int) {
        ad.isLoading()
        Get_Requests().brand_By_ID_Request(brandID:  id, page: pageNum, completion: { (rData ) in
            DispatchQueue.main.async {
                ad.killLoading()
                let newData = rData.productList
                self.data.append(contentsOf: newData)
                self.dismiss(animated: true, completion: nil)
            }
            
        }) { (err ) in
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    func getCatProducts(id : Int, pageNum : Int) {
        ad.isLoading()
        Get_Requests().category_By_Id(catID:  id, page: pageNum, completion: { (rData ) in
            DispatchQueue.main.async {
                ad.killLoading()

                self.dismiss(animated: true, completion: nil)
            }
            
        }) { (err ) in
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
 }
