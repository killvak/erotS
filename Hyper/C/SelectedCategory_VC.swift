//
//  SelectedBrandVC.swift
//  Hyper
//
//  Created by Killva on 3/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class SelectedCategory_VC: UIViewController {
    
    //MARK: Vars
    let cellID = "ProductCell"
    var  mainData = Categories_Specefications_Data(){
        didSet {
            self.cat_Data = mainData.categoriesData
            self.top_products = mainData.productsData
        }
    }
    let request = Get_Requests()

    var  cat_Data = [Cat_Brand_Data]()
    var top_products = [Product_Data]()
    var favCDItems :  [FavCD] = []
    var favItemsIDs : [Int] = []
    var favRequest : NSFetchRequest<FavCD>?
    var cartItemsIDs : [Int]?

    //MARK: OutLets

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")

        self.cartItemsIDs = self.fetchCdCartData()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCdData()
    }
    
    func fetchCdData() {
        
        
        favRequest  = FavCD.fetchRequest()
        guard let fData = favRequest else {
            print("🦊🦊🦊🦊🦊")
            return
        }
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(fData)
            self.favCDItems = recnt
            print(recnt.count)
            self.favItemsIDs = []
            for x in recnt {
                print(x.id)
                self.favItemsIDs.append( Int(x.id))
                //                re.append(x)
            }
            self.collectionView.reloadData()
        } catch {
            
        }
    }
    
    
    

    @IBAction func moreTopItemsHandler(_ sender: UIButton) {
        
        let vc = ProductsListVC()
        vc.title = title ?? ""
        vc.data = top_products
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func dissmissHandler(_ sender: UIButton) {
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


extension SelectedCategory_VC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat_Data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = cat_Data[indexPath.row].name
        cell.textLabel?.textColor = Constant.FontColorGray
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ad.isLoading()
        let id = cat_Data[indexPath.row].id
        request.getItem_By_SubCat(id: id, page: 1, completion: { (rData ) in
            
            
            DispatchQueue.main.async {
                guard rData.productList.count >= 1 else {
                    self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .warning)
                    ad.killLoading()
                    return
                }
                let vc = ProductsListVC()
                vc.data = rData.productList
                vc.fullData = rData
                vc.subCatID = id
                vc.pageTitleAddress = self.cat_Data[indexPath.row].name
                vc.title = self.cat_Data[indexPath.row].name
                self.navigationController?.pushViewController(vc, animated: true)
                ad.killLoading()
            }
        }, failure: { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        })
        
    }
    
    
    
}
extension SelectedCategory_VC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top_products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProductCell
        cell.configCell(data: top_products[indexPath.row])
        cell.backgroundColor = .clear
        
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self , action: #selector(showBtmMenu(_:)), for: .touchUpInside)
        cell.favBtn.setImage(nil, for: .normal)
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(addToFav(_:)), for: .touchUpInside)
        
        if  self.favItemsIDs.contains(top_products[indexPath.row].id) {
            cell.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
        }else {
            cell.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        self.getItemDetails(id: top_products[indexPath.row].id)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = self.collectionView.frame.height * 0.95
        let width = height / 1.4529411765
        return CGSize(width: width, height: height)
    }
    
    
    
    @objc func addToFav(_ sender : UIButton) {
        if let data = CoreDataClass.someEntityExistsInFavCD(id: top_products[sender.tag].id) {
            
            if  CoreDataClass.deleteFavItem(searchData: data) {
                if let index = favItemsIDs.index(of: self.top_products[sender.tag].id) {
                    favItemsIDs.remove(at: index)
                }
                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = FavCD(context: CoreDataClass.context)
            favCD.id = Int16(top_products[sender.tag].id)
            self.favItemsIDs.append(top_products[sender.tag].id)
            CoreDataClass.saveContext()
            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            
        }
        //        self.collectionView.reloadData()
    }
    
    
    @objc func showBtmMenu(_ sender : UIButton) {
        showMoreMenuWithCD(data: top_products[sender.tag], isBrand: false,cartCD : cartItemsIDs) { (ids) in
            self.cartItemsIDs = ids
            ad.killLoading()
        }
 
    }
    
    
    
    
}
