//
//  PhotoModel.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

public class PhotoModel: Object, Mappable {
    
    @objc dynamic var idNo: String? = ""
    @objc dynamic var ownerr: String? = ""
    @objc dynamic var secret : String? = ""
    @objc dynamic var server : String? = ""
    var farm : NSNumber = 0
    @objc dynamic var title: String? = ""
    var ispublic : NSNumber = 0
    var isfriend : NSNumber = 0
    var isfamily : NSNumber = 0
   
    
    
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    
   
    
    public func mapping(map: Map){
        idNo <- map["id"]
        ownerr <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
        ispublic <- map["ispublic"]
        isfriend <- map["isfriend"]
        isfamily <- map["isfamily"]
        
        
        
    }
}






