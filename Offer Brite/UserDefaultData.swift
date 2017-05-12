//
//  UserDefaultData.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/24/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
class UserDefaultsData {
    public static func setBool(_ key:String, value:Bool){
        AppDelegate.getUserDataInstance().set(value, forKey: key)
    }
    public static func getBool(_ key:String) -> Bool{
        return AppDelegate.getUserDataInstance().bool(forKey: key)
    }
    public static func setString(_ key:String, value:String){
        AppDelegate.getUserDataInstance().set(value, forKey: key)
    }
    public static func getString(_ key:String) -> String{
        return AppDelegate.getUserDataInstance().string(forKey: key)!
    }
    public static func setInteger(_ key:String, value:String){
        AppDelegate.getUserDataInstance().set(value, forKey: key)
    }
    public static func getInteger(_ key:String) -> Int{
        return AppDelegate.getUserDataInstance().integer(forKey: key)
    }
}
