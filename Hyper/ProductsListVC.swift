//
//  ProductsListVC.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ProductsListVC: UIViewController {

    //MARK: Vars
    let cellID = "ProductCell"
    //MARK: OutLets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTxt: UITextField!
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    

    @IBAction func filterhandler(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func backBtnHandler(_ sender: UIButton) {
        
   self.navigationController?.popViewController(animated: true)
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




extension ProductsListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProductCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.view.frame.width * 0.45
        let height = width * 1.4529411765
        return CGSize(width: width, height: height)
    }

    
    
    
    
}
