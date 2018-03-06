//
//  ViewController.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class HomePage: UIViewController {

    //MARK: Vars
    var brandCellID = "brandCellID"
    var categoryCellID = "categoryCellID"
    let reqest = Get_Requests()
    //MARK: OutLets
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    ////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
            
//        reqest.item_Details(item_ID: 1, completion: { (jData) in
//
//
//        }) { (err ) in
//
//
//        }
//        reqest.homeDetails_Request(completion: { (jData) in
//
//
//        }) { (err ) in
//
//
//        }
        reqest.brand_By_ID_Request(brandID: 1, page: 1, completion: { (jData ) in
            
            
        }) { (err ) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
 
    @objc func changeLang() {
        
   self.performSegue(withIdentifier: "go", sender: self)
//        let vc = ProductsListVC()
//
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func change() {
        
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        ad.reloadWithAnimation()
    }
 
}


extension HomePage : UICollectionViewDelegateFlowLayout ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == brandsCollectionView else {
            return 5
        }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == brandsCollectionView else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCell

            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandCellID, for: indexPath) as! BrandsCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        guard collectionView == brandsCollectionView else {
            let width = collectionView.frame.width * 0.5
            let height = collectionView.frame.height * 0.98
            return CGSize(width: width, height: height)
        }
 
        let randomNumCGFloat = CGFloat.random(min: 0.29, max: 0.42)
        var width : CGFloat!

            width =   collectionView.frame.width * randomNumCGFloat //indexPath.row   % 3 == 0 ? collectionView.frame.width * 0.42 : collectionView.frame.width *  0.35
        if indexPath.row  == 0  {
            width = collectionView.frame.width * 0.42
        }else      if indexPath.row  == 1 {
            width = collectionView.frame.width * 0.35
        }else      if indexPath.row  == 2 {
            width = collectionView.frame.width * 0.30
        }
        
        let height = width
        return CGSize(width: width, height: height!)
    }
    
    
    
    
    
}

