//
//  ItemsDetailsVC.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

fileprivate  enum CellTypeEnum {
    case Description,Specefications,Reviews
}
class ItemsDetailsVC: UIViewController {
    
    //MARK: Vars
 
    private   var cellType : CellTypeEnum!
    @IBOutlet weak var backBtn: UIButton!
    
    //MARK: OutLets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dealsLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var prPrice1Lbl: UILabel!
    @IBOutlet weak var prPrice2Lbl: UILabel!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var addTOCartBtn: UIButton!
    @IBOutlet weak var specBtn: UIButton!
    @IBOutlet weak var descBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var moreReviewsBTnHeight: NSLayoutConstraint!
    @IBOutlet weak var similarItemsCollectionView: UICollectionView!
     @IBOutlet weak var underLineSelectionView: UIView!
    
    //

    
    var underLineBtnSelection : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        underLineBtnSelection = self.underLineSelectionView.centerXAnchor.constraint(equalTo: self.specBtn.centerXAnchor, constant: 0    )
        underLineBtnSelection?.isActive = true

        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
        cellType = CellTypeEnum.Reviews
//        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
         tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        backBtn.addTarget(self, action: #selector(backNavBtnHandler), for: .touchUpInside)
     }
    
    
    
    
    
    @objc func changeLang() {
        
        
//         animateBtnSelection(reviewsBtn)
//        self.backNavBtnHandler()
        //        let vc = ProductsListVC()
        //
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
            }
    
    func animateBtnSelection(_ sender : UIButton) {
        
        
        cellType =   cellType == CellTypeEnum.Reviews ? CellTypeEnum.Description :  CellTypeEnum.Reviews
 
        
        self.underLineBtnSelection?.isActive = false
             self.underLineBtnSelection = self.underLineSelectionView.centerXAnchor.constraint(equalTo:sender.centerXAnchor, constant: 0    )
            self.underLineBtnSelection?.isActive = true
 
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        self.tableView.reloadData()
    }
    
    //MARK: BtnsActions
    
    @IBAction func moreBtnhandler(_ sender: UIButton) {
    }
    @IBAction func addToCartHandler(_ sender: UIButton) {
    }
    @IBAction func moreReviewsBtnHandler(_ sender: UIButton) {
    }
    @IBAction func cellTypeBtnsHandler(_ sender: UIButton) {
        
        animateBtnSelection(sender)
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


extension ItemsDetailsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cellType != CellTypeEnum.Reviews else {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard cellType != CellTypeEnum.Reviews else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "HO"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        return cell
        
    }
    
    
}
