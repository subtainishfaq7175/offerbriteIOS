//
//  UserModel.swift
//  SooperChef
//
//  Created by Ahsan Hameed on 3/15/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
class UserModel:Mappable{
    var userName:String?
    var email:String?
    var gender:String?
    var image:String?
    var phone:String?
    var userType:String?
    var country:String?
    var nationality:String?
    var website:String?
    var city:String?
    var dob:String?
    var LastLogin:String?
    var token:String?
    var status:Int?
    var id:Int?
    var profilePercentage:Int?

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
       userName <- map["username"]
        email <- map["email"]
        gender <- map["gender"]
        image <- map["image"]
        phone <- map["phone"]
        userType <- map["userType"]
        country <- map["country"]
        nationality <- map["nationality"]
        website <- map["website"]
        city <- map["city"]
        dob <- map["dob"]
        LastLogin <- map["Last_login"]
        token <- map["token"]
        status <- map["status"]
        id <- map["id"]
        profilePercentage <- map["profilePercentage"]


    }
    
}
