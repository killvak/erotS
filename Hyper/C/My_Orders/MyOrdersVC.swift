//
//  MyOrdersVC.swift
//  Hyper
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var fullData : [OrderDetails_Model] = []
    
     override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(withTitle: "My Orders")
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.rowHeight = 91.5
        tableView.register(UINib(nibName: "MyOrderCell", bundle: nil), forCellReuseIdentifier: "MyOrderCell")
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath) as! MyOrderCell
        cell.configCell(data: fullData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyOrderDetailsVC()
        vc.fullData = fullData[indexPath.row]
        vc.orderStatus =  fullData[indexPath.row].current_state
        vc.data = fullData[indexPath.row].cartProduct
        self.navigationController?.pushViewController(vc, animated: true)
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
