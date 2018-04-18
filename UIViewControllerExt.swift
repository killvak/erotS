//
//  UIViewControllerExt.swift
//  Hyper
//
//  Created by admin on 3/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import XLActionController
import CoreData

extension UIViewController {
    
    
    func hideKeyboardWhenTapped() {
        
        let tap  = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    func setupNav() {
        let navV = NavigationBarView()
        //        navV.translatesAutoresizingMaskIntoConstraints = false
        navV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54)
        self.view.addSubview(navV)
        navV.titleS = title ?? ""
        navV.backBtn.addTarget(self , action: #selector(dismissPushedView), for: .touchUpInside)
        
        
    }
    
    func setupNav(withTitle : String) {
        let navV = NavigationBarView()
        //        navV.translatesAutoresizingMaskIntoConstraints = false
        navV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54)
        self.view.addSubview(navV)
        navV.titleS = withTitle
        navV.backBtn.addTarget(self , action: #selector(dismissPushedView), for: .touchUpInside)
        
        
    }
    @objc func dismissPushedView() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func getItemDetails(id : Int ) {
        ad.isLoading()
        Get_Requests().item_Details(item_ID: id, completion: { (rData ) in
            //            let data = self.top_products[indexPath.row]
            ad.killLoading()
            let sb = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ItemsDetailsVC") as! ItemsDetailsVC
            vc.data = rData
            vc.title = rData.productsData?.name
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (err ) in
            print(err )
            DispatchQueue.main.async {
                self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
                ad.killLoading()
            }
        }
    }
    
    func getSearchFilterData(parms : [String:Any] , page : Int,completed : @escaping (ProductFull_Data)->(),failed : @escaping (String?)->()) {
        ad.isLoading()
        Post_Requests().postFilter_data(parms: parms, page: page, completion: { (rData ) in
            
            DispatchQueue.main.async {
                
                completed(rData)
                ad.killLoading()
            }
            
            
        }) { (err ) in
            
            DispatchQueue.main.async {
                ad.killLoading()
                self.showApiErrorSms(err: err)
                failed(err)
            }
        }
    }
    
    
    func showMoreMenu(data : Product_Data,isBrand:Bool,cartCD : [Int]?) {
        
        let actionController = YoutubeActionController()
        
        if let cartIDs = cartCD {
            print(data.id)
            let title  = cartIDs.contains(data.id) ?  L0A.remove_From_Cart.stringValue(): L0A.Add_To_Cart.stringValue()
            let img  = cartIDs.contains(data.id) ?  UIImage(named: "delete")! : UIImage(named: "ic_cart_unactive_")!
            actionController.addAction(Action(ActionData(title: title , image: img), style: .default, handler: { action in
                if let tabItems = self.tabBarController?.tabBar.items as NSArray!
                {
                    
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[4] as! UITabBarItem
                    tabItem.badgeValue = "\(cartIDs.count)"
                    self.saveCartCD(id: data.id, ids: cartIDs)
                }
                
            }))
        }
        if isBrand {
            actionController.addAction(Action(ActionData(title: L0A.Visit_Category.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
                
                //            self.tabBarController?.selectedIndex = 1
                self.navCategoryToProductsList(catID: data.id_main_category, pageNum: 1, pageTitle: data.category)
                
            }))
        }
        if !isBrand {
            actionController.addAction(Action(ActionData(title: L0A.Visit_Brand.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
                //            let vc = BrandsVC()
                let brandID = data.id_manufacturer
                //            self.navigationController?.pushViewController(vc, animated: true)
                self.navBrandToProductsList(brandID: brandID, pageNum: 1, pageTitle:  data.manufacturer)
            }))
        }
        actionController.addAction(Action(ActionData(title: L0A.Share.stringValue(), image: UIImage(named: "yt-share-icon")!), style: .default, handler: { action in
            
            let shareText = data.name
            var parm :[Any] = [shareText]
            if let url = URL(string : data.main_image )
            {
                parm.append(url)
            }
            
            let vc = UIActivityViewController(activityItems: parm, applicationActivities: [])
            self.present(vc, animated: true)
            
        }))
        actionController.addAction(Action(ActionData(title: L0A.Cancel.stringValue(), image: UIImage(named: "yt-cancel-icon")!), style: .cancel, handler: nil))
        
        present(actionController, animated: true, completion: nil)
    }
    
    func showMoreMenuWithCD(data : Product_Data,isBrand:Bool,cartCD : [Int]?,savedCart: @escaping ([Int]) -> ()) {
        
        let actionController = YoutubeActionController()
        
        if let cartIDs = cartCD {
            print(data.id)
            let title  = cartIDs.contains(data.id) ?  L0A.remove_From_Cart.stringValue(): L0A.Add_To_Cart.stringValue()
            let img  = cartIDs.contains(data.id) ?  UIImage(named: "yt-cancel-icon")! : UIImage(named: "ic_cart_unactive_")!
        actionController.addAction(Action(ActionData(title: title , image: img), style: .default, handler: { action in
            if let tabItems = self.tabBarController?.tabBar.items as NSArray!
            {
                ad.isLoading()
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[4] as! UITabBarItem
                tabItem.badgeValue = "\(cartIDs.count)"
                var dataEd = cartIDs
                self.saveCartCDWithEscaping(id: data.id, ids: &dataEd)
            savedCart(dataEd)
            }
            
        }))
    }
        if isBrand {
            actionController.addAction(Action(ActionData(title: L0A.Visit_Category.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
                
                //            self.tabBarController?.selectedIndex = 1
                self.navCategoryToProductsList(catID: data.id_main_category, pageNum: 1, pageTitle: data.category)
                
            }))
        }
        if !isBrand {
            actionController.addAction(Action(ActionData(title: L0A.Visit_Brand.stringValue(), image: UIImage(named: "yt-add-to-playlist-icon")!), style: .default, handler: { action in
                //            let vc = BrandsVC()
                let brandID = data.id_manufacturer
                //            self.navigationController?.pushViewController(vc, animated: true)
                self.navBrandToProductsList(brandID: brandID, pageNum: 1, pageTitle:  data.manufacturer)
            }))
        }
        actionController.addAction(Action(ActionData(title: L0A.Share.stringValue(), image: UIImage(named: "yt-share-icon")!), style: .default, handler: { action in
            
            let shareText = data.name
            var parm :[Any] = [shareText]
            if let url = URL(string : data.main_image )
            {
                parm.append(url)
            }
            
            let vc = UIActivityViewController(activityItems: parm, applicationActivities: [])
            self.present(vc, animated: true)
            
        }))
        actionController.addAction(Action(ActionData(title: L0A.Cancel.stringValue(), image: UIImage(named: "yt-cancel-icon")!), style: .cancel, handler: nil))
        
        present(actionController, animated: true, completion: nil)
    }
    
    func searchDidSelectResponse(data: ProductFull_Data?, catData: Categories_Specefications_Data?) {
        guard let dataa = catData else {
            guard let rData = data else { return}
            let vc = ProductsListVC(nibName: "ProductsListVC", bundle: nil)
            vc.data = rData.productList
            vc.fullData = rData
            vc.title = "Item"
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            return
        }
        let sb = self.storyboard ?? UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectedBrandVC") as! SelectedCategory_VC
        vc.mainData = dataa
        vc.title = dataa.cat_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showApiErrorSms(err : String?) {
        print(err )
        DispatchQueue.main.async {
            self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.NO_Data_to_Preview.stringValue(), .error)
            ad.killLoading()
        }
    }
    
    
    func navigatieToItemList(data: ProductFull_Data,pageTitleMap :String ) {
        
        let vc = ProductsListVC(nibName: "ProductsListVC", bundle: nil)
        //            vc.data = data.productList
        vc.fullData = data
        vc.title = pageTitleMap
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func openSearchVC() {
        let vc = SearchControllerVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self as? SearchControllerProtocol 
        self.present(vc, animated: true, completion: nil    )
    }
    
    
    
    func fetchCdCartData() -> [Int] {
        
        var cartCDItems :  [CartCD] = []
        var cartItemsIDs : [Int] = []
        var cartRequest : NSFetchRequest<CartCD>?
        cartRequest  = CartCD.fetchRequest()
        guard let fData = cartRequest else {
            print("🦊🦊🦊🦊🦊")
            return cartItemsIDs
        }
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(fData)
            cartCDItems = recnt
            print(recnt.count)
//
            for x in recnt {
                print(x.id)
                cartItemsIDs.append( Int(x.id))
                //                re.append(x)
            }
                return  cartItemsIDs
            //            collectionView.reloadData()
        } catch {    }
        
        return cartItemsIDs
        
    }
    
    
    
    func fetchCdFavData() -> [Int] {
        
        var favCDItems :  [FavCD] = []
        var favItemsIDs : [Int] = []
        var favRequest : NSFetchRequest<FavCD>?
        favRequest  = FavCD.fetchRequest()
        guard let fData = favRequest else {
            print("🦊🦊🦊🦊🦊")
            return []
        }
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(fData)
            favCDItems = recnt
            print(recnt.count)
            return  []
            for x in recnt {
                print(x.id)
                favItemsIDs.append( Int(x.id))
                //                re.append(x)
            }
            
            //            collectionView.reloadData()
        } catch { }
        
        return favItemsIDs
    }
    
    func saveCartCD(id : Int, ids:   [Int] ) {
        if let data = CoreDataClass.someEntityExistsInCartCD(id: id) {
            
            if  CoreDataClass.deleteCartItem(searchData: data) {
                if let index = ids.index(of:  id) {
                    
                 }
//                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = CartCD(context: CoreDataClass.context)
            favCD.id = Int16( id)
             CoreDataClass.saveContext()
//            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            print(fetchCdCartData())
            
        }
//        showCartCountOnTapBar(count : ids.count)
    }
    
    func saveCartCDWithEscaping(id : Int, ids: inout   [Int]  ) {
        if let data = CoreDataClass.someEntityExistsInCartCD(id: id) {
            
            if  CoreDataClass.deleteCartItem(searchData: data) {
                if let index = ids.index(of:  id) {
                    ids.remove(at:index)
                }
                //                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = CartCD(context: CoreDataClass.context)
            favCD.id = Int16( id)
            CoreDataClass.saveContext()
            //            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            ids.append(id)
            print(fetchCdCartData())
            
        }
        showCartCountOnTapBar(count : ids.count)
    }
    
    
    func saveCartCDWithEscapingHandler(id : Int, ids: inout   [Int]  , saved : @escaping ()->  ()  , deleted : @escaping ()->  ()  ) {
        if let data = CoreDataClass.someEntityExistsInCartCD(id: id) {
            
            if  CoreDataClass.deleteCartItem(searchData: data) {
                if let index = ids.index(of:  id) {
                    ids.remove(at:index)
                }
                //                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                deleted()
              
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = CartCD(context: CoreDataClass.context)
            favCD.id = Int16( id)
            CoreDataClass.saveContext()
            //            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            ids.append(id)
            saved()
 //            print(fetchCdCartData())
            
        }
       showCartCountOnTapBar(count : ids.count)
    }
    
    func saveCartCDWithEscapingHandler(id : Int, ids:   [Int]  , saved : @escaping ([Int])->  ()  , deleted : @escaping ([Int])->  ()  ) {
        var ids = ids
        if let data = CoreDataClass.someEntityExistsInCartCD(id: id) {
            
            if  CoreDataClass.deleteCartItem(searchData: data) {
                if let index = ids.index(of:  id) {
                    ids.remove(at:index)
                }
                //                sender.setImage(#imageLiteral(resourceName: "ic_fav_unactive_"), for: .normal)
                deleted(ids)
                
                CoreDataClass.saveContext()
            }else {
                
            }
        }else {
            
            let favCD = CartCD(context: CoreDataClass.context)
            favCD.id = Int16( id)
            CoreDataClass.saveContext()
            //            sender.setImage(#imageLiteral(resourceName: "ic_fav_active_items"), for: .normal)
            ids.append(id)
            saved(ids)
            //            print(fetchCdCartData())
            
        }
        showCartCountOnTapBar(count : ids.count)
    }
    
    func showCartCountOnTapBar(count : Int) {
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            
            let tabItem = tabItems[4] as! UITabBarItem
            tabItem.badgeValue = "\(count)"
        }
    }
}



