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
    @IBOutlet weak var signinBtnContainerView: UIView!
    var imgDict : [(String , UIImage)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        imgDict  = [(L0A.My_Order.stringValue(),UIImage(named:"ic_my_order_")!),//0
            (L0A.Edit.stringValue(),UIImage(named:"ic_edit_")!),//1
            (L0A.Address_Book.stringValue(),UIImage(named:"ic_address_book_")!),//2
            (L0A.Rate_US.stringValue(),UIImage(named:"ic_rate_us_")!),//3
            (L0A.My_Review.stringValue(),UIImage(named:"ic_revewis_")!),//4
            (L0A.Share.stringValue(),UIImage(named:"ic_share_")!),//5
            (L0A.Installment.stringValue(),UIImage(named:"ic_Installment_")!),//6
            (L0A.Sign_out.stringValue(),UIImage(named:"ic_logout_")!)]//7

        
        if !ad.isUserLoggedIn() {
           
            let vc = LoginVC()
            self.present(vc, animated: true, completion: nil)
            self.signinBtnContainerView.alpha = 1
            imgDict  = [
                (L0A.Rate_US.stringValue(),UIImage(named:"ic_rate_us_")!),//3
                (L0A.Share.stringValue(),UIImage(named:"ic_share_")!),//5
                  ]//7
        }else {
            getProfileData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    
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
    @IBAction func signBtnHandler(_ sender: UIButton? = nil) {
    
             let vc = LoginVC()
            self.present(vc, animated: true, completion: nil)
    }
    
    func getProfileData() {
        let id = ad.getUserID()
        guard  id != 0 else {
            ad.saveUserLogginData(email: nil, photoUrl: nil , uid:nil, name: nil)
            ad.reload()
            return }
        Get_Requests().get_Profile_Details(userID: id, completion: { (rData ) in
            
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
        let dataa = imgDict[indexPath.row].0
        switch dataa  {
        case L0A.My_Order.stringValue():
            self.tabBarController?.selectedIndex = 4
        case L0A.Edit.stringValue():
            let vc = EditProfileVC()
            self.present(vc, animated: true, completion: nil    )
            
        case L0A.Address_Book.stringValue():
            break
            
        case L0A.Rate_US.stringValue():
            rateApp( completion: { (booll) in
                print(booll)
            })
            
        case L0A.My_Review.stringValue():
            break
            
        case L0A.Share.stringValue():
            share()
            break
            
        case L0A.Installment.stringValue():
            break
            
        case L0A.Sign_out.stringValue(): //Logout
            ad.saveUserLogginData(email: nil, photoUrl: nil, uid: nil, name: nil)
            ad.reload()
 
        default:
            break 
        }
    }
    
    
    func share() {
        let shareText = "Hyper Techno"
        var parm :[Any] = [shareText]
//        if let url = URL(string : data.main_image )
//        {
//            parm.append(url)
//        }
        
        let vc = UIActivityViewController(activityItems: parm, applicationActivities: [])
        self.present(vc, animated: true)
    }
    func rateApp(  completion: @escaping ((_ success: Bool)->())) {
        let appId = 1241790691
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + "\(appId)") else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
}


