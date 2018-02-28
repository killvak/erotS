//
//  ItemsDetailsVC.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

fileprivate  enum CellTypeEnum : Int  {
    case Specefications = 0 ,Description = 1 ,Reviews = 2
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
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
        cellType = CellTypeEnum.Specefications
        //        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        backBtn.addTarget(self, action: #selector(backNavBtnHandler), for: .touchUpInside)

        similarItemsCollectionView.register(UINib(nibName: "SimilarItemsCell", bundle: nil), forCellWithReuseIdentifier: "SimilarItemsCell")

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
        guard cellType.rawValue != sender.tag else {
            print("EXIST")
            return
        }
        cellType = CellTypeEnum(rawValue: sender.tag)
        //        print(cellType.rawValue)
        //        print(cellType)
        //        cellType =   cellType == CellTypeEnum.Reviews ? CellTypeEnum.Description :  CellTypeEnum.Reviews
        
        
        self.underLineBtnSelection?.isActive = false
        UIView.animate(withDuration: 0.3) {

        self.underLineBtnSelection = self.underLineSelectionView.centerXAnchor.constraint(equalTo:sender.centerXAnchor, constant: 0    )
        self.underLineBtnSelection?.isActive = true
        
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
    
    let colors : [UIColor] = [Constant.BloodyRed,UIColor.purple,Constant.FontColorGray]
}

extension ItemsDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == colorsCollectionView else {
            
            return 10
        }
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == colorsCollectionView else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarItemsCell", for: indexPath) as! SimilarItemsCell
            return cell
         }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCell", for: indexPath) as! ColorsCell
        cell.colorView.backgroundColor = colors[indexPath.row]
        return cell
     }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard collectionView == colorsCollectionView else {

            return CGSize(width: collectionView.frame.height * 0.96, height:  collectionView.frame.height * 0.96)
        }
        
        return CGSize(width: 50, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard collectionView == colorsCollectionView else {
            
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorsCell {
            cell.isSelectedView(true)
        } else {
            // Error indexPath is not on screen: this should never happen.
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == colorsCollectionView else {
            
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorsCell {
            cell.isSelectedView(false)
        } else {
            // Error indexPath is not on screen: this should never happen.
        }
    }
}

extension ItemsDetailsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cellType == CellTypeEnum.Reviews else {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard cellType == CellTypeEnum.Reviews else {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text =  CellTypeEnum.Description  == cellType ? "Description" : "Specefication"
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        return cell
        
    }
    
    
}
