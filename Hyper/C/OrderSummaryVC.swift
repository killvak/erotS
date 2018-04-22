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
    @IBOutlet weak var pickAddressView: UIView!
    @IBOutlet weak var noAddressLbl: UILabel!
    
    //Footer
    @IBOutlet weak var getaCouponLbl: UILabel!
    @IBOutlet weak var paymentMethLbl: UILabel!
    @IBOutlet weak var orderPriceLbl: UILabel!
    @IBOutlet weak var priceAfterDiscountLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    
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
    
    var parms : [String:Any] = [:] 
    var data: [Product_Data] = []
    
    var addressData : Address_Model? {
        didSet {
            guard let rData = addressData else {
                self.noAddressLbl.text = L0A.Address_is_required.stringValue()
                self.noAddressLbl.alpha = 1
                return }
            self.addressLbl?.text = rData.fullAddress
            self.phoneNumLbl?.text = rData.ultiPhone
            self.nameLbl?.text = rData.userData.fullName
            self.noAddressLbl.alpha = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 126
        self.noAddressLbl.text = L0A.Address_is_required.stringValue()

        self.setupNav(withTitle : "Order Summary")
         if   let favaddre = UserDefaults.standard.value(forKey: Constant.parameters.UD_favAddID) as? Int , 1 == 2   {
            ad.isLoading()
            Post_Requests().user_addresse_by_id_Request(addressID: favaddre, parms: [:], success: { (rData ) in
                
                DispatchQueue.main.async {
                    ad.killLoading()
                    self.addressData = rData
                   
                }
                
            }) { (err ) in
                self.showApiErrorSms(err: err )
            }
         }else {
            perform(#selector(selectAddress), with: nil, afterDelay: 0.0)
            self.noAddressLbl.alpha = 1
        }
      //  tableView.register(UINib.init(nibName: "MyCartCell", bundle: nil), forCellReuseIdentifier: "MyCartCell")
        countPaymentSum()
        
        self.pickAddressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectAddress)))
    }
    
    
    
    @objc func selectAddress() {
        let vc = AddressBookVC()
        vc.delegate = self
        vc.isPickingAddress = true 
        self.navigationController?.pushViewController(vc, animated: true)
        
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
        self.totalLbl.text = "\(total)EGP"

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
        

    }
    
    @IBAction func enterCouponHandler(_ sender: UIButton) {
        
        let vc =  EnterCouponVC()
        vc.delegate = self
        customPresentViewController(customPresenter , viewController: vc, animated: true, completion: nil)
        
    }
    @IBAction func checkoutBtnHandler(_ sender: UIButton) {
        checkOut()
    }
    func checkOut() {
        
        guard let id = addressData?.address_id else {
             return
        }
        
        self.parms["address_id"]  = id
        ad.isLoading()
        Post_Requests().makeCart_Order_Request(parms: parms, success: {
            DispatchQueue.main.async {
//                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
//                self.navigationController?.pushViewController(vc, animated: true)
                self.view.showSimpleAlert(L0A.Success.stringValue(), "", .success )
                self.deletellCartData(success: {
                    self.showCartCountOnTapBar(count : 0)
                    ad.killLoading()
                    self.navigationController?.popToRootViewController(animated: true)

                }, failed: {
                    
                    ad.killLoading()
                    self.navigationController?.popToRootViewController(animated: true)

                })
            }
        }) { (err ) in
            self.showApiErrorSms(err: err )
        }

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

extension OrderSummaryVC : EnterCouponVCProtocol {
    func applyFilter(codeNum: String) {
        print(codeNum)
        getaCouponLbl.text = codeNum
    }
 
}


extension OrderSummaryVC : AddressBookVCProtocol {
    
    func fetchaddress(data: Address_Model) {
        
        self.addressData = data
        
    }
}
