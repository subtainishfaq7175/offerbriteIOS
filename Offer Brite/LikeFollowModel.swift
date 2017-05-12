//
//  LikeFollowModel.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/28/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class LikeFollowModel: Mappable {
    var userId:Int?
    var isFollowed:Int?
    var isLiked:Int?
    var status:Int?
    var offerId:Int?
    var id:Int?

   required init?(map: Map) {
        
    }
    
 func mapping(map: Map) {
    userId <- map["user_id"]
    isFollowed <- map["is_followed"]
    isLiked <- map["is_liked"]
    status <- map["status"]
    offerId <- map["offer_id"]
    id <- map["id"]
    }
}
