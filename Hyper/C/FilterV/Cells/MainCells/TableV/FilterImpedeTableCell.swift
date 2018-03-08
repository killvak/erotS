//
//  FilterImpedeTableCell.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FilterImpedeTableCell: UITableViewCell {

    @IBOutlet weak var dropDownimg: UIImageView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self 
        tableView.register(UINib(nibName: "CategoryTableCell", bundle: nil), forCellReuseIdentifier: "CategoryTableCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showTableV(_ sender: UIButton) {
        
        if tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 80
            }, completion: { (_) in
                
            })
        }else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 0
            }, completion: { (_) in
                
            })
            
        }
        
    }
    
    
    func selecteds() {
 
        if self.tableViewHeightCons.constant == 0 {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 220
                self.layoutIfNeeded()
            }, completion: { (_) in
                
            })
            UIView.transition(with: dropDownimg, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.dropDownimg.image = #imageLiteral(resourceName: "ic_arrow_up_")
            }) { (true) in
                
            }
         }else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn,.allowUserInteraction], animations: {
                self.tableViewHeightCons.constant = 0
                self.layoutIfNeeded()
            }, completion: { (_) in
                
            })
            UIView.transition(with: dropDownimg, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.dropDownimg.image = #imageLiteral(resourceName: "ic_arrow_dowen_")

            }) { (true) in
                
            }
        }
        
     }
}




extension FilterImpedeTableCell : UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableCell", for: indexPath) as! CategoryTableCell
        return cell 
    }
    
    
}
