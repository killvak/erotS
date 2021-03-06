//
//  ItemsDetailsVC.swift
//  Hyper
//
//  Created by admin on 2/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
import ImageSlideshow
import CoreData

fileprivate  enum CellTypeEnum : Int  {
    case Specefications = 0 ,Description = 1 ,Reviews = 2
}
class ItemsDetailsVC: UIViewController {
    
    //MARK: Vars
    
    private   var cellType : CellTypeEnum!
    var data = ItemDetails_Data(){
        didSet {
            productData = data.productsData
            relatedProducts = data.relatedProducts
            
        }
    }
    var productData :  Product_Data!
    var relatedProducts : [Product_Data] = []
    var favCDItems :  [FavCD] = []
    var favItemsIDs : [Int] = []
    var favRequest : NSFetchRequest<FavCD>?

    //MARK: OutLets
    @IBOutlet weak var offerContView: UIViewX!
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
    @IBOutlet weak var seeAllReviews: UIButton!
    @IBOutlet weak var moreReviewsBTnHeight: NSLayoutConstraint!
    @IBOutlet weak var similarItemsCollectionView: UICollectionView!
    @IBOutlet weak var underLineSelectionView: UIView!
     @IBOutlet weak var noColorsAvailabelLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    //
    
    var btnSelected = false
    var underLineBtnSelection : NSLayoutConstraint?
    var alamofireSource : [AlamofireSource] = []
    var cartItemsIDs : [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productData.colors)
        underLineBtnSelection = self.underLineSelectionView.centerXAnchor.constraint(equalTo: self.specBtn.centerXAnchor, constant: 0    )
        underLineBtnSelection?.isActive = true
        
        // Do any additional setup after loading the view.
        //        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
        cellType = CellTypeEnum.Specefications
        //        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
 
        similarItemsCollectionView.register(UINib(nibName: "SimilarItemsCell", bundle: nil), forCellWithReuseIdentifier: "SimilarItemsCell")
        setupView()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 46
        setupNav(withTitle: L0A.Item.stringValue())
        self.shareBtn.addTarget(self, action: #selector(showBtmMenu(_:)), for: .touchUpInside)
        
        if productData.reviews.count == 0 {
            self.moreReviewsBTnHeight.constant = 0
        }
        favBtn.setImage(nil, for: .normal)
         favBtn.addTarget(self, action: #selector(addToFav(_:)), for: .touchUpInside)
        
        self.cartItemsIDs = self.fetchCdCartData()
        if  let _ = cartItemsIDs.index(of:  productData.id)  {
        self.addTOCartBtn.setTitle(L0A.remove_From_Cart.stringValue(), for: .normal)
    } else {
    self.addTOCartBtn.setTitle(L0A.Add_To_Cart.stringValue(), for: .normal)
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCdData()
    }
    
    @objc func showBtmMenu(_ sender : UIButton) {
//        showMoreMenu(data: productData)
        let shareText = productData.name
        var parm :[Any] = [shareText]
        if let url = URL(string : productData.main_image )
        {
            parm.append(url)
        }
        
        let vc = UIActivityViewController(activityItems: parm, applicationActivities: [])
        self.present(vc, animated: true)
    }
    func fetchCdData() {
        
        
        self.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
        favRequest  = FavCD.fetchRequest()
        guard let fData = favRequest else {
            print("🦊🦊🦊🦊🦊")
            return
        }
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(fData)
            self.favCDItems = recnt
            print(recnt.count)
            for x in recnt {
                print(x.id)
                self.favItemsIDs.append( Int(x.id))
                //                re.append(x)
                if x.id == productData.id {
                    self.favBtn.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
                }
            }
         } catch {
            
        }
    }
    @objc func addToFav(_ sender : UIButton) {
        if let data = CoreDataClass.someEntityExistsInFavCD(id: productData.id) {
            
            if  CoreDataClass.deleteFavItem(searchData: data) {
                if let index = favItemsIDs.index(of: productData.id) {
                    favItemsIDs.remove(at: index)
                }
                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = FavCD(context: CoreDataClass.context)
            favCD.id = Int16(productData.id)
            self.favItemsIDs.append(productData.id)
            CoreDataClass.saveContext()
            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            
        }
        //        self.collectionView.reloadData()
    }
    
    func setupSlideShow() {
        
        
        slideshow.backgroundColor = UIColor.clear 
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = Constant.BloodyRed
        slideshow.pageControl.pageIndicatorTintColor = Constant.BackGroundGray
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
         slideshow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSlideShow))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    @objc func didTapSlideShow() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    
    func setupView() {
        
        productImg.setupApiImage(imagePath: productData.main_image)
        
        dealsLbl.text = productData.new_code
        pTitle.text = productData.name
        
        if productData.on_sale {
            prPrice1Lbl.strikeIt(text: productData.wholesale_price)
            prPrice2Lbl.alpha = 1
            prPrice2Lbl.text = productData.reduction_price
            dealsLbl.text = "\(productData.reduction_percent)%"
            prPrice1Lbl.textColor = Constant.FontColorGray
            dealsLbl.text = "\(productData.reduction_percent)%"
            offerContView.alpha = 1
        }else {
            prPrice2Lbl.alpha = 0
            prPrice1Lbl.textColor = Constant.BloodyRed
              offerContView.alpha = 0
            if let price = data.productsData?.price {
                prPrice1Lbl.text = "\(price) L.E"

            }
        }
        
      

        self.alamofireSource = []
        if let url = URL(string : self.productData.main_image )  {
            let img = AlamofireSource(url: url, placeholder: #imageLiteral(resourceName: "pic_items"))
            alamofireSource.append(img)
            self.productImg.alpha = 0
        }
         for x in productData.images {
            print(x)
            if let url = URL(string : x.image )  {
                let img = AlamofireSource(url: url, placeholder: #imageLiteral(resourceName: "pic_items"))
                alamofireSource.append(img)
             }
        }

         self.setupSlideShow()

        if productData.colors.count == 0 {
//            let filteredConstraints = colorsCollectionView.constraints.filter { $0.identifier == "Height" }
//            if let heightConstraint = filteredConstraints.first {
//                // DO YOUR LOGIC HERE
//                heightConstraint.constant = 20
//                 self.view.layoutIfNeeded()
//            }
            self.noColorsAvailabelLbl.text = L0A.No_Colors_Available.stringValue()
            self.noColorsAvailabelLbl.alpha = 1
            
        }else {
            self.noColorsAvailabelLbl.alpha = 0
        }
        
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
        btnSelected = true
    }
    
    //MARK: BtnsActions
    
    @IBAction func moreBtnhandler(_ sender: UIButton) {
        
        let productData = ProductFull_Data()
        productData.productList = self.relatedProducts
        
        self.navigatieToItemList(data: productData, pageTitleMap: " \(self.productData.manufacturer) > \(L0A.related_Item.stringValue())")
        
    }
    @IBAction func addToCartHandler(_ sender: UIButton) {
//        self.saveCartCDWithEscaping(id: productData.id, ids: &cartItemsIDs)
        
        self.saveCartCDWithEscapingHandler(id: productData.id, ids: &cartItemsIDs, saved: {
            self.addTOCartBtn.setTitle(L0A.remove_From_Cart.stringValue(), for: .normal)
        }) {
            self.addTOCartBtn.setTitle(L0A.Add_To_Cart.stringValue(), for: .normal)
        }
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
            
            return relatedProducts.count
        }
        return productData.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == colorsCollectionView else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarItemsCell", for: indexPath) as! SimilarItemsCell
            cell.configCell(data: relatedProducts[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCell", for: indexPath) as! ColorsCell
        cell.configCell(data: productData.colors[indexPath.row])
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
        if productData.reviews.count <= 3 ,productData.reviews.count  > 0 {
            return productData.reviews.count
        }else if productData.reviews.count == 0 {
            return 1
        }else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard cellType == CellTypeEnum.Reviews else {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text =  CellTypeEnum.Description  == cellType ? productData.description : productData.highlights
            cell.backgroundColor = .clear
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            return cell
        }
        if  productData.reviews.count  == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = L0A.No_reviews_Yet.stringValue()
            cell.backgroundColor = .clear
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            return cell
         }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            
            return cell
         
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard btnSelected else { return }
         cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            }, completion: { (_) in
                self.btnSelected = false
            })
        })
    }
    
    
}
