//
//  ViewController.swift
//  Hyper
//
//  Created by admin on 2/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class HomePage: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(changeLang)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
 
    @objc func changeLang() {
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

