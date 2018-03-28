//
//  ViewController.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//
import UIKit
import FSPagerView

class HomePage: UIViewController {

    //MARK: Vars
    var brandCellID = "brandCellID"
    var categoryCellID = "categoryCellID"
    let request = Get_Requests()
    
    var brands : [Cat_Brand_Data] = []
    var categories : [Cat_Brand_Data] = []
    var promotions : [Promotions_Data] = []
    var refreshControl: UIRefreshControl!

    //MARK: OutLets
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    ////
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
 addPullToRefreshC()
updateData()
        
        setupPagerV()
        updateSearchData()
         gertSearchData()
    }
    
    func gertSearchData() {
        
        Get_Requests().search_Sugettions(completion: {
            
            
        }) { (err ) in
            self.showApiErrorSms(err: err )
        }
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
      
        DispatchQueue.main.async {
//            self?.brandsCollectionView.reloadData()
//            self?.categoryCollectionView.reloadData()
            self?.brands = jData.brandsData
            self?.categories = jData.categoriesData
            self?.promotions = jData.promotionsData
            self?.pagerView.reloadData()
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
        
//   self.performSegue(withIdentifier: "go", sender: self)
//        let vc = ProductsListVC()
//
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func showMoreHandler(_ sender: UIButton) {
    
        let isCat = sender.tag == 1
        guard !isCat else {
            self.tabBarController?.selectedIndex = 1
            return
        }
        ad.isLoading()
        request.all_Data_about(categories: isCat, brands: !isCat, page: 1, completion: { [unowned self ] (rData) in
            
            DispatchQueue.main.async {
                
                 ad.killLoading()
              
                    let vc = BrandsVC(nibName: "BrandsVC", bundle: nil)
                    vc.data = rData
                    vc.isCat = isCat
                vc.title = isCat ? L0A.All_Categories.stringValue() : L0A.All_Brands.stringValue()
                     self.navigationController?.pushViewController(vc, animated: true)
             }
          
        }) { [weak self ](err )  in
            
            self?.showApiErrorSms(err: err )
        }
        
    }
    
    func updateSearchData() {
        
        Get_Requests().all_Data_about(categories: true, brands: false, page: 1, completion: { (_) in
        }) { (r ) in
            
        }

        Get_Requests().all_Data_about(categories: false, brands: true, page: 1, completion: { (_) in
        }) { (_ ) in
            print("wtf")
        }
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
            
            navCategoryToProductsList(catID: categories[indexPath.row].id, pageNum: 1, pageTitle: self.categories[indexPath.row].name)
            
            return
        }
        navBrandToProductsList(brandID: brands[indexPath.row].id, pageNum: 1, pageTitle:  brands[indexPath.row].name)
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
//        UIView.animate(withDuration: 0.8) {
//            cell.alpha = 1
//        }
        
        UIView.animate(withDuration: 0.8, delay: 0.09, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            cell.alpha = 1 
        }, completion: nil)
    
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



extension HomePage : FSPagerViewDataSource , FSPagerViewDelegate  {
    
    func setupPagerV() {
        
        pagerView.delegate = self
        pagerView.dataSource  = self
        pagerView.automaticSlidingInterval = 6.5
        pagerView.transformer = FSPagerViewTransformer(type: .cubic)
        pagerView.isInfinite = true
        
    }
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return promotions.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        guard promotions.count >= 1 else {
            cell.imageView?.image = #imageLiteral(resourceName: "adv_hot_")
            return  cell
        }
        guard let url = URL(string: promotions[index].image ) else {
            
            return cell
            
        }
        
        print("id_image:\(promotions[index].id_image)opening: \(promotions[index].image) ")
         cell.imageView?.af_setImage(
            withURL: url ,
            placeholderImage: UIImage(named: "adv_pic_"),
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
//            cell.textLabel?.text = "hi"
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
}
