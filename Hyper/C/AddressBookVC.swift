//
//  AddressBookVC.swift
//  Hyper
//
//  Created by Killva on 3/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class AddressBookVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var data : [Address_Model] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 132
        self.setupNav()
        tableView.register(UINib.init(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        
        cell.configCell(data:data[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ad.getUserID())
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
