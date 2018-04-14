//
//  MyCartVC.swift
//  Hyper
//
//  Created by Killva on 4/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MyCartVC: UIViewController  , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedToCheckoutBtn: UIButton!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var cartCdIDs : [Int] = []
    var data : [Product_Data] = []
    
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
          getData()
    }
    
    func getData() {
        cartCdIDs = self.fetchCdCartData()
        let parm = [ "ids" : cartCdIDs ]
        ad.isLoading()
        Post_Requests().getListOfItems_Request(parms: parm, success: { (rData ) in
            
            DispatchQueue.main.async {
                self.data = rData
                self.tableView.reloadData()
                var price = 0
                for x in rData {
                    
                    price += x.price
                 }
                self.totalPriceLbl.text = "\(price)"
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
    
        cell.configCell(data:data[indexPath.row])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ad.getUserID())
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func proceedToCheckoutBtnHandler(_ sender: UIButton) {
        
        
        
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
