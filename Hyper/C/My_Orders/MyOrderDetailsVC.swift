//
//  MyOrderDetailsVC.swift
//  Hyper
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MyOrderDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inprocessingLbl: UILabel!
    @IBOutlet weak var inprocessingLine: UIView!
    @IBOutlet weak var confirmedLbl: UILabel!
    @IBOutlet weak var confirmedLine: UIView!
    @IBOutlet weak var shippedLbl: UILabel!
    @IBOutlet weak var shippedLine: UIView!
    @IBOutlet weak var deliveredLbl: UILabel!

    @IBOutlet weak var inprocessingLblTitle: UILabel!
    @IBOutlet weak var confirmedLblTitle: UILabel!
    @IBOutlet weak var shippedLblTitle: UILabel!
    @IBOutlet weak var deliveredLblTitle: UILabel!

    @IBOutlet weak var serialNumLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var deliveryDateLbl: UILabel!
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    
    //Address
    @IBOutlet weak var nameAddressLbl: UILabel!
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    //Footer
     @IBOutlet weak var paymentMethLbl: UILabel!
    @IBOutlet weak var orderPriceLbl: UILabel!
    @IBOutlet weak var priceAfterDiscountLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    
    var orderStatus : OrderStatusType!
    var fullData : OrderDetails_Model?
    var data : [Order_Cart_DetailsModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(withTitle: "My Order Details")
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "OrderDetailsCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsCell")
        setupCellByType(type: orderStatus)
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.rowHeight = 126
        
        setupUIData()
    }
    
    func setupUIData() {
        guard let data = fullData else {
            return
        }
        serialNumLbl.text  = L0A.shipmment_Num.stringValue() + " \(data.id) "
        timeLbl.text = data.date_add
        deliveryDateLbl.text = data.date_add
        deliveryTimeLbl.text = data.date_upd
countPaymentSum()
        setupAddressUIData()
    }
    func countPaymentSum() {
        var price = 0
        let shippingCost = 100
        
        for x in self.data {
            price += x.quantity * x.product_wholesale_price
        }
        
        self.orderPriceLbl.text = "\(price)EGP"
        self.priceAfterDiscountLbl.text = "\(price)EGP"
        self.shippingLbl.text = "\(shippingCost)EGP"
        let total = price + shippingCost
        self.totalLbl.text = "\(total)EGP"
        
    }
    
    func setupAddressUIData() {
        guard let rData = fullData?.address else {
             return }
        self.addressTitleLbl.text = rData.fullAddress
        self.phoneLbl.text = rData.ultiPhone
        self.nameAddressLbl.text = rData.userData.fullName
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsCell", for: indexPath) as! OrderDetailsCell
        cell.configCell(data: data[indexPath.row])
        return cell
    }
    
    
    private func setupCellByType(type : OrderStatusType ) {
        
        switch type {
            
        case .in_Processing:
            self.inprocessingLbl.backgroundColor = .deafultGreen
            inprocessUI()
        case .Shipped:
          let color  : UIColor  =  .deafultGreen
          
          self.shippedLbl.backgroundColor = color
            shippedUI()
        case .Delivered:
            let color  : UIColor  =  .green
            
            self.deliveredLbl.backgroundColor = color
            deliveredUI()
        case .Canceled: break
//            let color  : UIColor  =  .darkText
//            let statusTitle =  L0A.canceled.stringValue()
//            self.inprocessingLbl.text = statusTitle
//            self.inprocessingLbl.backgroundColor = color
         case .Confirmed:
            let color  : UIColor  =  .purple
           
            self.confirmedLbl.backgroundColor = color
            confirmedUI()
         }
        
        
    }
    
    
    func inprocessUI() {
        let color  : UIColor =  .deafultGreen
        let statusTitle =  L0A.in_Processing.stringValue()
        self.inprocessingLblTitle.text = statusTitle
        self.inprocessingLbl.backgroundColor = color
        self.inprocessingLblTitle.textColor = color
    }
    
    func confirmedUI() {
        inprocessUI()
        let color  : UIColor =  .deafultGreen
        self.confirmedLblTitle.textColor = .purple
        self.confirmedLbl.backgroundColor = .purple
        let statusTitle =  L0A.confirmed.stringValue()
        self.confirmedLblTitle.text = statusTitle
        self.inprocessingLine.backgroundColor = color

    }
    
    
    func shippedUI() {
         confirmedUI()
        let color  : UIColor =  .deafultGreen
        self.confirmedLbl.backgroundColor = color
        self.shippedLblTitle.textColor = .weirdOrange
        self.shippedLbl.backgroundColor = .weirdOrange
        self.confirmedLblTitle.textColor = color

        let statusTitle =  L0A.shipped.stringValue()
        self.shippedLblTitle.text = statusTitle
        self.confirmedLine.backgroundColor = color

    }
    
    func deliveredUI() {
        shippedUI()
        let color  : UIColor =  .deafultGreen
        self.shippedLblTitle.textColor = color
        self.shippedLbl.backgroundColor = color
        self.deliveredLblTitle.textColor = color
        self.deliveredLbl.backgroundColor = color
        let statusTitle =  L0A.delivered.stringValue()
        self.deliveredLblTitle.text = statusTitle
        self.shippedLine.backgroundColor = color

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
