//
//  DrawerItemModel.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/25/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import Foundation
import ObjectMapper
class DrawerItemModel : Mappable{
    var drawerItemLabel:String?
    var id:Int?
    required init?(map: Map) {
    }
    init(_ catName:String, id:Int) {
        self.drawerItemLabel = catName
        self.id = id
    }
    func mapping(map: Map) {
        drawerItemLabel <- map["cat_name"]
        id <- map["id"]
        
    }
}
