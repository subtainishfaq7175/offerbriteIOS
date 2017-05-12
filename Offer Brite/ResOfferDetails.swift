//
//  ResOfferDetails.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/28/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class ResOfferDetails: Mappable {
    var isResponse:Bool?
    var responseCode:String?
    var responseMessage:String?
    var data:OfferModel?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        isResponse <- map["response"]
        responseCode <- map["response_code"]
        responseMessage <- map["response_message"]
        data <- map["response_data"]
    }
}
