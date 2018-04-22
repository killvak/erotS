//
//  FavListVC.swift
//  Hyper
//
//  Created by admin on 4/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData
class FavListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favListIsEmptyLbl: UILabel!

     var data : [Product_Data] = [] {
        didSet {
            self.favListIsEmptyLbl?.alpha = data.count >= 1 ? 0 : 1
        }
    }
    var favCDItems :  [FavCD] = []
    var favItemsIDs : [Int] = []
    var favRequest : NSFetchRequest<FavCD>?
    var cartCdIDs : [Int]?

    private let cellID = "ProductCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
 
        
        collectionView.delegate = self
        collectionView.dataSource = self
         collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         fetchCdData()
        cartCdIDs = self.fetchCdCartData()
         getData()

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
        } catch {
            
        }
    }
    
    
    func getData() {
        guard self.favCDItems.count >= 1 else {
            self.data = []
             self.collectionView.reloadData()
            return
        }
        ad.isLoading()
        Post_Requests().getListOfItems_Request(ids: favItemsIDs, success: { (rData ) in
            
            DispatchQueue.main.async {
                self.data = rData
                self.collectionView.reloadData()
                   ad.killLoading()
                
            }
        }) { (err ) in
            self.showApiErrorSms(err: err)
        }
        
    }
    
    
    @IBAction func proceedToCheckoutBtnHandler(_ sender: UIButton) {
        
        
        var items  : [ Any] = []
        for x in data {
            print(x.id , x.quantity)
            let parm = [
                "item_quantity": x.quantity,
                "item_id": x.id
            ]
            items.append(parm)
        }
        let parms : [String : Any ]  = [
            "user_id": "\(ad.getUserID())",
            "address_id": "9",
            "items": items
        ]
        print(parms)
        //        Post_Requests().makeCart_Order_Request(parms: parms, success: {
        //            DispatchQueue.main.async {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
        vc.data = data
        vc.parms = parms
        self.navigationController?.pushViewController(vc, animated: true)
        //            }
        //        }) { (err ) in
        //            self.showApiErrorSms(err: err )
        //        }
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



extension FavListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProductCell
        cell.configCell(data: data[indexPath.row])
        cell.backgroundColor = .clear
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self , action: #selector(showBtmMenu(_:)), for: .touchUpInside)
        cell.favBtn.setImage(nil, for: .normal)
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(addToFav(_:)), for: .touchUpInside)
        
        if  self.favItemsIDs.contains(data[indexPath.row].id) {
            cell.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
        }else {
            cell.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
        }
        return cell
    }
    
    @objc func addToFav(_ sender : UIButton) {
        if let data = CoreDataClass.someEntityExistsInFavCD(id: data[sender.tag].id) {
            
            if  CoreDataClass.deleteFavItem(searchData: data) {
                if let index = favItemsIDs.index(of: self.data[sender.tag].id) {
                    favItemsIDs.remove(at: index)
                }
                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                for x in self.data {
                    print(x.id , self.data[sender.tag].id)
                    if x.id == self.data[sender.tag].id {
                        self.data.remove(at: sender.tag)
                        self.collectionView.reloadData()
                        return
                    }
                }
                CoreDataClass.saveContext()
                
            }else {
                
            }
        }else {
            
            let favCD = FavCD(context: CoreDataClass.context)
            favCD.id = Int16(data[sender.tag].id)
            self.favItemsIDs.append(data[sender.tag].id)
            CoreDataClass.saveContext()
            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
         
            
        }
        //        self.collectionView.reloadData()
    }
    @objc func showBtmMenu(_ sender : UIButton) {
        print(cartCdIDs)
        //        showMoreMenu(data: data[sender.tag], isBrand: true,cartCD : cartCdIDs)
        
        showMoreMenuWithCD(data: data[sender.tag], isBrand: true, cartCD: cartCdIDs) { (ids) in
            self.cartCdIDs = ids
            ad.killLoading()
        }
        //        cartCdIDs = self.fetchCdCartData()
        
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
