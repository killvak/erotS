//
//  MyCartVC.swift
//  Hyper
//
//  Created by Killva on 4/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class MyCartVC: UIViewController  , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedToCheckoutBtn: UIButton!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var cartCdIDs : [Int] = []
    var data : [Product_Data] = []
    var favCDItems :  [FavCD] = []
    var cartData : [CartCD] = []
    var favItemsIDs : [Int] = []
    var favRequest : NSFetchRequest<FavCD>?
    var totalPrice = 0 {
        didSet{
            self.totalPriceLbl.text = "\(self.totalPrice)"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 163

        tableView.register(UINib.init(nibName: "MyCartCell", bundle: nil), forCellReuseIdentifier: "MyCartCell")
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.totalPrice = 0 
        fetchCdData()
       fetchCartData()
        getData()
    }
    func fetchCartData() {
        let cdData = fetchCdCartFullData()
        cartCdIDs = cdData.1
        cartData = cdData.0
        tableView.reloadData()
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
        guard self.cartCdIDs.count >= 1 else {
            self.data = []
            self.totalPriceLbl.text = ""
            self.tableView.reloadData()
            return
        }
         ad.isLoading()
        Post_Requests().getListOfItems_Request(ids: cartCdIDs, success: { (rData ) in
            
            DispatchQueue.main.async {
                self.data = rData
                self.tableView.reloadData()
                for (i,x) in rData.enumerated() {
                    
                    
                    if self.cartData[i].id == x.id {
                         let price2  = x.price * Int(self.cartData[i].quantity)
                        self.totalPrice += price2
                    }else {
                        self.totalPrice += x.price
                    }
                 }
                
                self.totalPriceLbl.text = "\(self.totalPrice)"
                ad.killLoading()
                
            }
        }) { (err ) in
            self.showApiErrorSms(err: err)
        }
    
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as! MyCartCell
        if cartData[indexPath.row].id == data[indexPath.row].id {
            data[indexPath.row].newQuantity = Int(cartData[indexPath.row].quantity)
            cell.quantityLbl.text = "\(cartData[indexPath.row].quantity)"
        }
        cell.configCell(data:data[indexPath.row])
      
        cell.mycartVC = self
        cell.removeBtn.tag = indexPath.row
        cell.favBtn.tag = indexPath.row
        cell.removeBtn.addTarget(self, action: #selector(removeItemFromCart(_:)), for: .touchUpInside)
        cell.favBtn.addTarget(self, action: #selector(addItemToFav(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func removeItemFromCart(_ sender : UIButton) {
    let id = data[sender.tag].id
        

        self.saveCartCDWithEscapingHandler(id: id, ids: self.cartCdIDs, saved: { (ids ) in

        }) { (ids ) in
                        self.cartCdIDs = ids
            print(ids , self.cartCdIDs)
            self.getData()
        }
    }
    
    @objc func addItemToFav(_ sender : UIButton) {
        if let data = CoreDataClass.someEntityExistsInFavCD(id: data[sender.tag].id) {
            
            if  CoreDataClass.deleteFavItem(searchData: data) {
                if let index = favItemsIDs.index(of: self.data[sender.tag].id) {
                    favItemsIDs.remove(at: index)
                }
                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(ad.getUserID())
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
        let vc = EditAddAddressVC()
        self.navigationController?.pushViewController(vc, animated: true)
//        let data = self.data[indexPath.row]
//
//        self.getItemDetails(id: data.id)

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
