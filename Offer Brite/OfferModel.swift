//
//  OfferModel.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/28/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class OfferModel: Mappable {
    var isLiked:Bool?
    var isFollowed:Bool?
    var likes:[LikeFollowModel]?
    var followes:[LikeFollowModel]?
    var title:String?
    var description:String?

    var banner:String?
    var startDate:String?
    var endDate:String?
    var starthours:String?
    var endHours:String?
    var additionalInformation:String?

    
    var categoryId:Int?
    var id:Int?
    var totalLikes:Int?
    var totalFollows:Int?
    var created_by:Int?
    var is_public:Int?

    required init?(map: Map) {
        
    }
     func mapping(map: Map) {
        isLiked <- map ["isLiked"]
        isFollowed <- map ["isfollowed"]
        
        likes <- map ["Likes"]
        followes <- map ["Follows"]

        title <- map ["title"]
        description <- map ["description"]
        startDate <- map ["startDate"]
        endDate <- map ["endDate"]
        starthours <- map ["starthours"]
        endHours <- map ["EndHours"]
        additionalInformation <- map ["additionalInformation"]

        categoryId <- map ["categoryId"]
        created_by <- map ["created_by"]
        is_public <- map ["is_public"]
        id <- map ["id"]
        totalLikes <- map ["totalLikes"]
        totalFollows <- map ["totalFollows"]
        
    }
}
