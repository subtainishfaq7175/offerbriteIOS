//
//  Login.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/20/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class Login: UIViewController , UITextFieldDelegate, UIScrollViewDelegate{

    @IBOutlet weak var guestLabel: UIView!
    @IBOutlet weak var signupLable: UILabel!
    @IBOutlet weak var passwordTF: HoshiTextField!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailTF: HoshiTextField!
    var activeField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addGustures()
        scrollview.delegate = self
        activeField?.delegate = self
        registerForKeyboardNotifications()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
