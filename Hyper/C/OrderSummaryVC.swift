//
//  OrderSummaryVC.swift
//  Hyper
//
//  Created by Killva on 4/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Presentr


class OrderSummaryVC: UIViewController   , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //Header
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
 
    //Footer
    @IBOutlet weak var paymentMethLbl: UILabel!
    @IBOutlet weak var orderPriceLbl: UILabel!
    @IBOutlet weak var priceAfterDiscountLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

 
    var parms : [String:Any] = [:] 
    var data: [Product_Data] = []
    
    var addressData : Address_Model? {
        didSet {
            guard let rData = addressData else { return }
            self.addressLbl?.text = rData.fullAddress
            self.phoneNumLbl?.text = rData.ultiPhone
            self.nameLbl?.text = rData.userData.fullName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 126
        self.setupNav(withTitle : "Order Summary")
         if   let favaddre = UserDefaults.standard.value(forKey: Constant.parameters.UD_favAddID) as? Int    {
            ad.isLoading()
            Post_Requests().user_addresse_by_id_Request(addressID: favaddre, parms: [:], success: { (rData ) in
                
                DispatchQueue.main.async {
                    ad.killLoading()
                    self.addressData = rData
                   
                }
                
            }) { (err ) in
                self.showApiErrorSms(err: err )
            }
        }
      //  tableView.register(UINib.init(nibName: "MyCartCell", bundle: nil), forCellReuseIdentifier: "MyCartCell")
        countPaymentSum()
    }
    
    func countPaymentSum() {
        var price = 0
        let shippingCost = 100
        for x in self.data {
            price += x.quantity * x.price
        }
        self.orderPriceLbl.text = "\(price)EGP"
        self.priceAfterDiscountLbl.text = "\(price)EGP"
        self.shippingLbl.text = "\(shippingCost)EGP"
        let total = price + shippingCost
        self.orderPriceLbl.text = "\(total)EGP"

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSummaryCell", for: indexPath) as! OrderSummaryCell
        cell.configCell(data: data[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(ad.getUserID())
//        checkOut()
        
            let vc =  EnterCouponVC()
        customPresentViewController(customPresenter , viewController: vc, animated: true, completion: nil)

    }
    
    func checkOut() {
        self.parms["address_id"]  = "9"

        Post_Requests().makeCart_Order_Request(parms: parms, success: {
            DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }) { (err ) in
            self.showApiErrorSms(err: err )
        }

    }
    
    
    lazy  var customPresenter: Presentr  = {
        let w : Float = 310
        let h : Float  = 194
        let width = ModalSize.custom(size: w)
        let height = ModalSize.custom(size: h)
        let y = ( UIScreen.main.bounds.height  -  CGFloat( h) ) / 2.8
        let x =  ( UIScreen.main.bounds.width  -   CGFloat(w) ) / 2
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: x, y: y))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVerticalFromTop
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = true
        customPresenter.backgroundColor = .black
        customPresenter.backgroundOpacity = 0.78
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .top
        return customPresenter
    }()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
 
}
