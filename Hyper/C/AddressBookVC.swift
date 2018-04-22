//
//  AddressBookVC.swift
//  Hyper
//
//  Created by Killva on 3/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol AddressBookVCProtocol : class  {
    
    func fetchaddress(data : Address_Model)
    
}


class AddressBookVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var data : [Address_Model] = [] 
    
    var isPickingAddress = false
    weak var delegate : AddressBookVCProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 132
        self.setupNav()
        tableView.register(UINib.init(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    
    func getData() {
        ad.isLoading()
        Post_Requests().getAddress_Request(success: { (rData) in
            DispatchQueue.main.async {
                self.data = rData
                print(self.data)
                self.tableView.reloadData()
                ad.killLoading()
            }
        }) { (err ) in
            self.showApiErrorSms(err: err)
        }
    }
    @IBAction func addNewAddressBtnHandler(_ sender: UIButton) {
        
        let vc = EditAddAddressVC()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        
        cell.configCell(data:data[indexPath.row])
        
        cell.favBtn.setImage(nil, for: .normal)
        print(UserDefaults.standard.value(forKey: "favAddID") )
        print(data[indexPath.row].address_id)
        if let favaddre = UserDefaults.standard.value(forKey: "favAddID") as? Int , favaddre == data[indexPath.row].address_id{
            cell.favBtn.setImage(UIImage(named:"ic_fav_active_"), for: .normal)

        }else {
            cell.favBtn.setImage(UIImage(named:"ic_fav_unactive_star"), for: .normal)

        }
        cell.favBtn.tag = data[indexPath.row].address_id
        cell.favBtn.addTarget(self, action: #selector(addToFav(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func addToFav(_ sender : UIButton) {
 print(UserDefaults.standard.value(forKey: Constant.parameters.UD_favAddID) )
        print(sender.tag)
        if  UserDefaults.standard.value(forKey: Constant.parameters.UD_favAddID) == nil {
            UserDefaults.standard.setValue(sender.tag , forKey: Constant.parameters.UD_favAddID)
            self.tableView.reloadData()

        }else  if   let favaddre = UserDefaults.standard.value(forKey: Constant.parameters.UD_favAddID) as? Int , favaddre != sender.tag   {
            UserDefaults.standard.setValue(sender.tag , forKey: Constant.parameters.UD_favAddID)
            self.tableView.reloadData()
        }else {
            UserDefaults.standard.setValue(nil , forKey: "favAddID")
            self.tableView.reloadData()

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isPickingAddress else {
            
            let vc = EditAddAddressVC()
            vc.addressData = self.data[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        print(ad.getUserID())
        
        delegate?.fetchaddress(data: data[indexPath.row])
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
