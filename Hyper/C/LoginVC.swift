//
//  SplashLoginVC.swift
//  Breeze-User
//
//  Created by admin on 11/12/17.
//  Copyright © 2017 CreativeMinds. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Google

class LoginVC: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
//    @IBOutlet weak var orLbl: UILabel!
    
    let postRequest = Get_Requests()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupL02()
        // print(self.navigationController?.viewControllers)
        //        self.navigationController?.viewControllers.remove(at: 0)
        //        print(self.navigationController?.viewControllers)
        
        // Do any additional setup after loading the view.
    }
    
    func setupL02() {
        fbBtn.setTitle(L0S.Sign_Up_With_Facebook.stringValue(), for: .normal)
        signupBtn.setTitle(L0S.Sign_Up_With_Phone_or_Email.stringValue(), for: .normal)
        googleBtn.setTitle(L0S.Sign_Up_With_Google.stringValue(), for: .normal)
        signinBtn.setTitle(L0S.Already_have_an_account.stringValue(), for: .normal)
//        orLbl.text = L102Language.currentAppleLanguage() == "ar" ? " أو ": " Or "
    }
    
    //to be deleted
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { [ weak self] (connection, result, error) -> Void in
                
                if (error == nil) {
                    if let resultDict = result as? [String: AnyObject] {
                        var userDict = Dictionary<String,String>()
                        userDict["social_id"] = resultDict["id"] as? String ?? ""
                        userDict["first_name"] = resultDict["first_name"] as? String ?? ""
                        userDict["email"] = resultDict["email"] as? String ?? ""
                        userDict["last_name"] = resultDict["last_name"] as? String ?? ""
                        userDict["provider"] = "fb"
                        userDict["type"] = "2"
                        userDict["access_token"] = FBSDKAccessToken.current().tokenString
                       
                        
//                        self?.postRequest.socialRegister(Constants.API.URLS_Post_Enum.Social_Register, userDict, completed: {
//                            (failure, message) in
//                            if(!failure)
//                            {
//                                DispatchQueue.main.async{
//                                    UserDefaults.standard.set(message, forKey: "token")
//                                    print("++++++++++++++++++++")
//                                    print("token is : \(message)")
//
//                                    print("++++++++++++++++++++")
//
//                                    UserDefaults.standard.synchronize()
//                                    ad.reloadWithAnimation()
//                                    ad.checkIfTokenSent()
//                                }
//                            }
//                            else
//                            {
//                                DispatchQueue.main.async {
//                                    self?.view.showSimpleAlert(L0A.Error.stringValue(), message, .warning)
//                                }
//                            }
//
//                        })
                        
                    }
                    
                    //print("\n\n\nToken is \(FBSDKAccessToken.current().tokenString)")
                    
                    
                }
                else {
                    //self.showAlert(message: "Something went wrong, Please try again later.")
                }
            })
        }
    }
    //ends here
    
    
    @IBAction func facebookHandler(_ sender: UIButton) {
        //        let vc = CustomSplashScreen()
        //        self.present(vc, animated: true, completion: nil)
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if((fbloginresult.grantedPermissions) != nil) {
                    self.getFBUserData()
                }
                else if (fbloginresult.isCancelled) {
                    
                }
            }
            else {
                print(error)
            }
        }
    }
    
    
    @IBAction func signinHandler(_ sender: UIButton) {
//        let vc = LoginVC()
//        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func signupHandler(_ sender: UIButton) {
//        let vc = UINavigationController.init(rootViewController:  RegistrationVC())
//        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func googleHandler(_ sender: UIButton) {
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self;
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        viewController.dismiss(animated: true, completion: nil)
        //NotificationCenter.default.post(name: .closeLoginVC, object: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        ad.isLoading()
        
        if (user != nil) {
            let userId = user.userID as String                // For client-side use only!
            //let idToken = user.authentication.idToken as String // Safe to send to the server
            let fullName = user.profile.name as String
            let givenName = user.profile.givenName as String
            let familyName = user.profile.familyName as String
            let email = user.profile.email as String
            var userDict = Dictionary<String,String>()
            userDict["social_id"] = userId
            userDict["first_name"] = givenName
            userDict["email"] = email
            userDict["last_name"] = familyName
            userDict["provider"] = "gp"
            userDict["type"] = "2"
            userDict["access_token"] = user.authentication.accessToken
            
            
            
//            self.postRequest.socialRegister(Constants.API.URLS_Post_Enum.Social_Register, userDict, completed: {
//                (failure, message) in
//                if(!failure)
//                {
//                    DispatchQueue.main.async{
//                        UserDefaults.standard.set(message, forKey: "token")
//                        print("++++++++++++++++++++")
//                        print("token is : \(message)")
//                        print("++++++++++++++++++++")
//                        UserDefaults.standard.synchronize()
//                        ad.reloadWithAnimation()
//                        ad.checkIfTokenSent()
//                    }
//                }
//                else
//                {
//                    signIn.signOut()
//                    DispatchQueue.main.async {
//                        self.view.showSimpleAlert(L0A.Error.stringValue(), message, .warning)
//                        ad.killLoading()
//                    }
//                }
//
//            })
            
        }
        else {
            ad.killLoading()
            //self.showAlert(message: "Something went wrong, Please try again later.")
        }
    }
    
//    func bookingCompleteAcknowledged(){
//        //remove the popup controller
//        dismiss(animated: true, completion: nil)
//        //remove current controller
//        dismiss(animated: true, completion: nil)
//
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//
//            if let navcontroller = topController.childViewControllers[0] as? UINavigationController{
//                navcontroller.popToRootViewController(animated: false)
//
//                if let funnelcontroller = navcontroller.childViewControllers[0] as? CustomSplashScreen{
//                    funnelcontroller.removeFromParentViewController();
//                    funnelcontroller.view.removeFromSuperview();
//
//                    let revealController = self.storyboard?.instantiateViewController(withIdentifier: "rootNav")
//
//                    navcontroller.addChildViewController(revealController!)
//                    navcontroller.view.addSubview((revealController?.view)!)
//                }
//            }
//        }
//
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


