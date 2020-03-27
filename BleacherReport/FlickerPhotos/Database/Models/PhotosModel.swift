//
//  PhotosModel.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

public class PhotosModel: Object, Mappable {
    
    
    var page: NSNumber = 0
    var pages: NSNumber = 0
    var perpage: NSNumber = 0
    @objc dynamic var total: String? = ""
    
    
    var photo = List<PhotoModel>()
    
   
    
 
    
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    
    
    
    public func mapping(map: Map){
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        total <- map["total"]
        
       photo <- (map["photo"], ListTransform<PhotoModel>())
        
        
        
    }
}





