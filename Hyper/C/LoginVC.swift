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
import SkyFloatingLabelTextField

class LoginVC: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var emailTxtF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxt: SkyFloatingLabelTextField!
    //    @IBOutlet weak var orLbl: UILabel!
    
    let postRequest = Post_Requests()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupL02()
        // print(self.navigationController?.viewControllers)
        //        self.navigationController?.viewControllers.remove(at: 0)
        //        print(self.navigationController?.viewControllers)
        
        // Do any additional setup after loading the view.
        hideKeyboardWhenTapped()
    }
    
    func setupL02() {
        fbBtn.setTitle(L0S.Sign_Up_With_Facebook.stringValue(), for: .normal)
//        signupBtn.setTitle(L0S.Sign_Up_With_Phone_or_Email.stringValue(), for: .normal)
        googleBtn.setTitle(L0S.Sign_Up_With_Google.stringValue(), for: .normal)
//        signinBtn.setTitle(L0S.Already_have_an_account.stringValue(), for: .normal)
//        orLbl.text = L102Language.currentAppleLanguage() == "ar" ? " أو ": " Or "
    }
    
    //to be deleted
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email "]).start(completionHandler: { [ weak self] (connection, result, error) -> Void in
                
                if (error == nil) {
                    if let resultDict = result as? [String: AnyObject] {
                        var userDict = Dictionary<String,String>()
                        
                        guard let email = resultDict["email"] as? String, let id = resultDict["id"] as? String , let firstName = resultDict["first_name"] as? String, let lastname = resultDict["last_name"] as? String  else {
                            
                            return
                        }
                        
                        userDict["fb_id"] =  id
                        userDict["first_name"] = firstName
                        userDict["email"] = email
                        userDict["last_name"] = lastname
                          userDict["fb_token"] = FBSDKAccessToken.current().tokenString
                        if let imageURL = ((resultDict["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                            //Download image from imageURL
                            print(imageURL)
                            userDict["picture"] = imageURL
                         }
 //                            {
//                                 "birthday": "string",
//                                "picture": "string",
//                                "gender": "string",
//                          }
//                         print(userDict)
                        
                        DispatchQueue.main.async {
                            ad.isLoading()
                        }
                        
                        self?.postRequest.social_Login(postType: .fB_Login, parms: userDict , completion: { (rData) in
                            
//                            print(rData)
                            ad.saveUserLogginData(email: rData.email , photoUrl: userDict["picture"], uid: rData.id, name: rData.fullName)
                            ad.reload()
                        }, failure: { (err ) in
                             self?.showApiErrorSms(err: err )
                         })
 
                        
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
    @IBAction func dismissViewHandler(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil    )
 
        
        
    }
    
    
    @IBAction func forgotPassHandler(_ sender: UIButton) {
    }
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
        self.view.endEditing(true)
        guard let email = emailTxtF.text , email.isEmail else  {
            self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.Invalid_Email.stringValue(), .warning)
            return
        }
        guard let pass = passwordTxt.text , pass.isValidPassword else  {
            self.view.showSimpleAlert(L0A.Warning.stringValue(), L0A.Invalid_Password_.stringValue(), .warning)
            return
        }
        
        let parm = [
            "password": "string",
            "email": "string"
         ]
        ad.isLoading()
         postRequest.social_Login(postType: .email_Login, parms: parm , completion: { (rData ) in
            print(rData)
            DispatchQueue.main.async {
                ad.saveUserLogginData(email: rData.email , photoUrl:nil, uid: rData.id, name: rData.fullName)
                ad.reload()
                ad.killLoading()

            }
        }) { (err ) in
            if  let error = err ,  let errorID = Int(error )    {
                DispatchQueue.main.async {
               self.LoginAPiErrorSMS(errID: errorID)
                    ad.killLoading()
                }
                return
            }
          

            self.showApiErrorSms(err: err )
        }
      
    }
    
    func LoginAPiErrorSMS(errID : Int ){
        var sms = ""
        switch errID {
        case 0:
            sms = L0A.Please_Check_your_E_mail.stringValue()
        case 1 : sms = L0A.Invalid_Password_.stringValue()
        case 2 :  sms = L0A.Invalid_Email.stringValue()
        default:
             sms = L0A.Invalid_Email.stringValue()
        }
        self.view.showSimpleAlert(L0A.Sorry.stringValue(), sms, .error)
        
    }
    
    func userLoggedIn(userData : Profile_Details_M) {
        
        
    }
    @IBAction func signupHandler(_ sender: UIButton) {
//        let vc = UINavigationController.init(rootViewController:  RegistrationVC())
        let vc = RegisterVC()
        self.present(vc, animated: true, completion: nil)
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
            let img = user.profile.imageURL(withDimension: 200)
            var userDict = Dictionary<String,String>()
            userDict["id"] = userId
            userDict["first_name"] = givenName
            userDict["email"] = email
            userDict["last_name"] = familyName
              userDict["access_token"] = user.authentication.accessToken
             userDict["picture"] =  img?.absoluteString
//            print(userDict)
            
                 ad.isLoading()
 
            self.postRequest.social_Login(postType: .google_Login, parms: userDict , completion: { (rData) in
                
                 ad.saveUserLogginData(email: rData.email , photoUrl: userDict["picture"], uid: rData.id, name: rData.fullName)
                ad.reload()
            }, failure: { (err ) in
                self.showApiErrorSms(err: err )
            })
            
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


