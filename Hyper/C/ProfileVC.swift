//
//  ProfileVC.swift
//  Hyper
//
//  Created by admin on 3/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ProfileVC: FilterViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImageV: UIImageViewX!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    var imgDict : [(String , UIImage)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
          imgDict  = [(L0A.My_Order.stringValue(),UIImage(named:"ic_my_order_")!),(L0A.Edit.stringValue(),UIImage(named:"ic_edit_")!),(L0A.Address_Book.stringValue(),UIImage(named:"ic_address_book_")!),(L0A.Rate_US.stringValue(),UIImage(named:"ic_rate_us_")!),(L0A.My_Review.stringValue(),UIImage(named:"ic_revewis_")!),(L0A.Share.stringValue(),UIImage(named:"ic_share_")!),(L0A.Installment.stringValue(),UIImage(named:"ic_Installment_")!),(L0A.Sign_out.stringValue(),UIImage(named:"ic_logout_")!)]
        
        getProfileData() 
    }
    
    
    @IBAction func changeLanghandler(_ sender: UIButton) {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootNav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
         UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    func getProfileData() {
        
        Get_Requests().get_Profile_Details(userID: 1, completion: { (rData ) in
            
            self.emailLbl.text = rData.email
            self.nameLbl.text = rData.first_name + " " + rData.last_name
            self.profileImageV.setupApiImage(imagePath: rData.image,placeHolderImg: UIImage(named:"ic_profile_pic_") ?? #imageLiteral(resourceName: "ic_profile_pic"))
            
         }) { (err ) in
            self.showApiErrorSms(err: err )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.iconImageV.image = imgDict[indexPath.row].1
        cell.titleLbl.text = imgDict[indexPath.row].0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 5
        return CGSize(width: width, height: width * 1.5 )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
//
////        let vc = AddressBookVC(nibName: "AddressBookVC", bundle: nil)
//          self.navigationController?.pushViewController(vc, animated: true)
        switch indexPath.row  {
        case 0:
            self.tabBarController?.selectedIndex = 4
        case 1:
            break
            
        case 2:
            break
            
        case 3:
            break
            
        case 4:
            break
            
        case 5:
            break
            
        case 6:
            break
            
        case 7:
            break
 
        default:
            break 
        }
    }
}


