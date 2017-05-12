//
//  AppUtils.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/25/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
class AppUtils {
    public static var instance:AppUtils?
    public static func getInstance() -> AppUtils{
        if instance == nil {
            instance = AppUtils()
        }
        return instance!
    }
    func setToggle(){
        AppDelegate.getDelegateInstance().centerContainer!.toggle(.left, animated: true, completion: nil)
        
    }
    func setAlert(alert vc:UIViewController, title:String, message:String, alertAction:UIAlertAction, alertActionNo:UIAlertAction) {
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(alertActionNo)
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    func makeToast(forView vc:UIViewController, message:String,seconds duration:Double){
        let toastView = UIView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(Constants.STANDARD_ALPHA)
        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.numberOfLines = Constants.VALUE_ZERO_INT
        toastLabel.font = UIFont.systemFont(ofSize: Constants.STANDARD_FONT_SIZE_SMALL)
        toastLabel.text = message
        toastLabel.frame = CGRect(x: Constants.VALUE_ZERO_CGF, y: Constants.VALUE_ZERO_CGF, width: vc.view.frame.width, height:Constants.VALUE_TEN_CGF)
        let textSize  = toastLabel.sizeThatFits(toastLabel.bounds.size)
        var labelFrame = toastLabel.frame
        labelFrame.size.height = textSize.height + Constants.MARGIN_LABEL_WITHIN_VIEW
        toastLabel.textAlignment  = .center
        toastLabel.frame = labelFrame
        toastView.frame = CGRect(x: Constants.VALUE_FIVE_CGF, y: vc.view.frame.height - (Constants.TOAST_BOTTOM_MARGIN + textSize.height), width: toastLabel.frame.size.width - Constants.VALUE_TEN_CGF, height: toastLabel.frame.size.height)
        toastView.addSubview(toastLabel)
        toastView.layer.cornerRadius = Constants.VALUE_FIVE_CGF
        vc.view.addSubview(toastView)
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now()) + (duration)) {
            toastView.removeFromSuperview()
        }
    }
    func genActivityIndicatorView(_ vc:UIViewController, message:String) -> UIView{
        let view = UIView()
        view.tag = Constants.INDICATOR_TAG_ID
        view.backgroundColor = UIColor.black.withAlphaComponent(Constants.STANDARD_ALPHA)
        view.frame = CGRect(x: Constants.VALUE_ZERO_CGF, y: Constants.VALUE_ZERO_CGF, width: Constants.VALUE_HUNDRAD_CGF, height: Constants.VALUE_HUNDRAD_CGF)
        let activityIndcator = UIActivityIndicatorView()
        activityIndcator.frame = CGRect(x: Constants.VALUE_ZERO_CGF, y: Constants.VALUE_ZERO_CGF, width: Constants.TOAST_BOTTOM_MARGIN, height: Constants.TOAST_BOTTOM_MARGIN)
        activityIndcator.center =  view.center
        activityIndcator.startAnimating()
        view.addSubview(activityIndcator)
        let lable = UILabel()
        lable.frame = CGRect(x: Constants.VALUE_ZERO_CGF, y: activityIndcator.frame.origin.y + activityIndcator.frame.size.height , width: Constants.VALUE_HUNDRAD_CGF, height: Constants.VALUE_TWENTY_FIVE_CGF)
        lable.textAlignment = .center
        lable.text = message
        lable.textColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: Constants.STANDARD_FONT_SIZE_SMALL)
        view.addSubview(lable)
        view.layer.cornerRadius = Constants.VALUE_TEN_CGF
        view.center = vc.view.center
        return view
        
    }
    func checkStringData(_ str:String?) -> String {
        if  str != nil && str != Constants.EMPTY_STRING {
            return str!
            
        }else {
           return Constants.NA_STR
        }
    }
    func storeUserData(_ data:UserModel)  {
        if data.userName != nil{
            AppDelegate.getUserDataInstance().set(data.userName, forKey: DefaultDataConstants.USER_NAME)
        }
        if data.email != nil{
            AppDelegate.getUserDataInstance().set(data.email, forKey: DefaultDataConstants.USER_EMAIL)
 
        }
        if data.token != nil{
            AppDelegate.getUserDataInstance().set(data.token, forKey: DefaultDataConstants.USER_TOKEN)

        }
        if data.phone != nil{
            AppDelegate.getUserDataInstance().set(data.phone, forKey: DefaultDataConstants.USER_PHONE)

        }
        if data.image != nil{
            AppDelegate.getUserDataInstance().set(data.image, forKey: DefaultDataConstants.USER_PIC)

        }
        if data.profilePercentage != nil{
            AppDelegate.getUserDataInstance().set(data.profilePercentage, forKey: DefaultDataConstants.PROFILE_PERCENTAGE)
            
        }
    }
    func clearUserData()  {
            AppDelegate.getUserDataInstance().set(Constants.EMPTY_STRING, forKey: DefaultDataConstants.USER_NAME)
            AppDelegate.getUserDataInstance().set(Constants.EMPTY_STRING, forKey: DefaultDataConstants.USER_EMAIL)
            AppDelegate.getUserDataInstance().set(Constants.EMPTY_STRING, forKey: DefaultDataConstants.USER_TOKEN)
            AppDelegate.getUserDataInstance().set(Constants.EMPTY_STRING, forKey: DefaultDataConstants.USER_PHONE)
            AppDelegate.getUserDataInstance().set(Constants.EMPTY_STRING, forKey: DefaultDataConstants.USER_PIC)
            AppDelegate.getUserDataInstance().set(Constants.VALUE_ZERO_INT, forKey: DefaultDataConstants.PROFILE_PERCENTAGE)
        
    }

    
}
