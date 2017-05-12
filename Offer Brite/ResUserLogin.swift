//
//  ResUserLogin.swift
//  SooperChef
//
//  Created by Ahsan Hameed on 3/15/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class ResUserLogin: Mappable {
    var isResponse:Bool?
    var responseCode:String?
    var status:String?
    var data:UserModel?
    var message:String?
    var responseType:String?

    required init?(map: Map) {
    
    }
     func mapping(map: Map) {
        isResponse <- map["response"]
        status <- map["status"]
        data <- map["response_data"]
        responseType <- map["response_type"]
        message <- map["response_message"]
        responseCode <- map["response_code"]

    }
}
