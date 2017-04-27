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
}
