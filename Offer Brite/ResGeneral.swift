//
//  ResGeneral.swift
//  SooperChef
//
//  Created by Ahsan Hameed on 12/22/16.
//  Copyright © 2016 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class ResGeneral: Mappable {
    var isResponse:Bool?
    var status:String?
    var message:String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.isResponse <- map["isResponse"]
        self.status <- map["status"]
        self.message <- map["message"]
        
        
    }
}
