//
//  Login.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/20/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit
import Alamofire
class Login: UIViewController , UITextFieldDelegate, UIScrollViewDelegate{

    @IBAction func loginAction(_ sender: Any) {
        loginTapped()
    }
    @IBOutlet weak var guestLabel: UIView!
    @IBOutlet weak var signupLable: UILabel!
    @IBOutlet weak var passwordTF: HoshiTextField!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailTF: HoshiTextField!
    var errorMessage:String = ""
    var indicatorView = UIView()
    var userEmail = String()
    var userPassword = String()
    var activeField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicatorView = AppUtils.getInstance().genActivityIndicatorView(self, message: Constants.LOADING)

        addGustures()
        scrollview.delegate = self
        activeField?.delegate = self
        registerForKeyboardNotifications()
    }
    
    
    
    func loginTapped()  {
        emailTF.endEditing(true)
        passwordTF.endEditing(true)
        if checkEmptyTF(emailTF, message:Constants.EMAIL_MISSING) && checkEmptyTF(passwordTF, message:Constants.PASSWORD_MISSING){
            self.userEmail = emailTF.text!
            self.userPassword = passwordTF.text!
            userLogin(userEmail, password: userPassword )
        }
        else{
            customToast(errorMessage)
        }
        
    }
    func customToast(_ message:String)  {
        AppUtils.getInstance().makeToast(forView: self, message: message, seconds: Constants.TOAST_SHORT_TIME)
    }
    func checkEmptyTF(_ tf:UITextField, message:String) -> Bool {
        var email = ""
        if tf.text == Constants.EMPTY_STRING {
            errorMessage = message
            return false
        }
        if tf == emailTF {
            email = emailTF.text!
        }
        if email != Constants.EMPTY_STRING{
            if !(email.isEmail){
                errorMessage = message
                return false
            }
        }
        
        return true
    }
    func userLogin(_ email:String, password:String)  {
        if Reachability.isConnectedToNetwork(){
            view.addSubview(indicatorView)
            let params:Parameters =  [ConstantsKeyPairs.EMAIL: email, ConstantsKeyPairs.PASSWORD: password]
            Alamofire.request(ServerConstants.LOGIN, method: .post, parameters:params, encoding: URLEncoding(destination: .httpBody), headers: AppDelegate.getDelegateInstance().getRequestHeader())
                .responseObject{
                    (response: DataResponse<ResUserLogin>) in
                    self.indicatorView.removeFromSuperview()
                    switch response.result{
                    case .success:
                        if let data = response.result.value{
                            if data.isResponse! {
                                if data.data != nil {
                                    UserDefaultsData.setBool(DefaultDataConstants.IS_FIRST_TIME, value: false)
                                    UserDefaultsData.setBool(DefaultDataConstants.IS_USER_LOGIN, value: true)
                                    AppUtils.getInstance().storeUserData(data.data!)
                                    AppDelegate.getDelegateInstance().presentInitialVC()
                                }
                            }
                            if data.message != nil {
                                self.customToast(data.message!)
                            }
                        }
                        break
                    case .failure:
                        if (response.result.error?.localizedDescription) != nil {
                            self.customToast((response.result.error?.localizedDescription)!)
                        }
                        break
                    }
            }
            
        }else{
            if indicatorView.tag == Constants.INDICATOR_TAG_ID {
                indicatorView.removeFromSuperview()
            }
            noInternet()
        }
    }
  
    func noInternet() {
        var alertAction = UIAlertAction()
            alertAction = UIAlertAction(title:  Constants.YES , style: UIAlertActionStyle.default) { (a:UIAlertAction) in
                self.userLogin(self.userEmail, password: self.userPassword)
            }
        let alertActionNo:UIAlertAction = UIAlertAction(title: Constants.NO, style: UIAlertActionStyle.default) { (a:UIAlertAction) in
        }
        AppUtils.getInstance().setAlert(alert: self, title: Constants.NO_INTERNET_TITLE, message: Constants.NO_INTERNET_MSG, alertAction: alertAction, alertActionNo: alertActionNo)
    }
    func addGustures() {
        signupLable.isUserInteractionEnabled = true
        guestLabel.isUserInteractionEnabled = true
        let signupGesture = UITapGestureRecognizer(target: self, action: #selector(presentSignupVC(_:)))
        let guestGesture = UITapGestureRecognizer(target: self, action: #selector(presentHomeVC(_:)))
        signupLable.addGestureRecognizer(signupGesture)
        guestLabel.addGestureRecognizer(guestGesture)
    }
    func presentSignupVC(_ notify:UIGestureRecognizer) {
        let signupVC = AppDelegate.getDelegateInstance().storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_SIGNUP) as! SignUp
        present(signupVC, animated: true, completion: nil)
    }
    func presentHomeVC(_ notify:UIGestureRecognizer) {
       AppDelegate.getDelegateInstance().setDrawer()
    }
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollview.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollview.contentInset = contentInsets
        self.scrollview.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollview.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollview.contentInset = contentInsets
        self.scrollview.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollview.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
