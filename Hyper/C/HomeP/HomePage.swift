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
    let request = Get_Requests()
    
    var brands : [Brands_Data] = []
    var categories : [Categories_Data] = []
    var refreshControl: UIRefreshControl!

    //MARK: OutLets
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    ////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
 addPullToRefreshC()
updateData()
     
    }

    func addPullToRefreshC() {
        scrollView.alwaysBounceVertical = true
        scrollView.bounces  = true
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.scrollView.addSubview(refreshControl)
    }
   @objc func updateData() {
        ad.isLoading()
        print("Refersh")
    request.homeDetails_Request(completion: { [weak self ] (jData) in
        self?.brands = jData.brandsData
        self?.categories = jData.categoriesData
        
        DispatchQueue.main.async {
//            self?.brandsCollectionView.reloadData()
//            self?.categoryCollectionView.reloadData()
            self?.brandsCollectionView.animateCells()
            self?.categoryCollectionView.animateCells()
            self?.refreshControl?.endRefreshing()
            ad.killLoading()
        }
        
        
    }) { [unowned self ] (err )  in
        
        print(err)
        DispatchQueue.main.async {
              self.refreshControl?.endRefreshing()
            ad.killLoading()
        }
    }
        // For End refrshing
    
        
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
            return categories.count
        }
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == brandsCollectionView else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCell
            cell.configCell(data: categories[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandCellID, for: indexPath) as! BrandsCell
        cell.configCell(data: brands[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        guard collectionView == brandsCollectionView else {
            
            ad.isLoading()
            request.category_By_Id(catID: categories[indexPath.row].id, page: 1, completion: { (rData) in
                
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedBrandVC") as! SelectedBrandVC
                    vc.mainData = rData
                    vc.title = self.categories[indexPath.row].name
                    self.navigationController?.pushViewController(vc, animated: true)
                    ad.killLoading()
                }
            }, failure: { (err ) in
                print(err )
                DispatchQueue.main.async {
                    self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                    ad.killLoading()
                }
            })
            
            return
        }
        
        
         let data = brands[indexPath.row]
        ad.isLoading()
        request.brand_By_ID_Request(brandID: data.id, page: 1, completion: { [unowned self ](rData) in
            guard rData.count >= 1 else {
                DispatchQueue.main.async {
                 self.view.showSimpleAlert(L0A.Sorry.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .warning)
                ad.killLoading()
                }
                    return
            }
            DispatchQueue.main.async {
                let vc = ProductsListVC(nibName: "ProductsListVC", bundle: nil)
                vc.data = rData
                self.navigationController?.pushViewController(vc, animated: true)
                 ad.killLoading()
            }
         
            
            
        }) { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        guard collectionView == brandsCollectionView else {
            let width = collectionView.frame.width * 0.5
            let height = collectionView.frame.height * 0.98
            return CGSize(width: width, height: height)
        }
 
        let randomNumCGFloat = CGFloat.random(min: 0.32, max: 0.42)
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
    
    
   
      func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
    
      func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? BrandsCell {
                cell.produuctImgV.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
        }
    }
    
      func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? BrandsCell {
                cell.produuctImgV.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
}


