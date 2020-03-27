//
//  FlickerModel.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

public class FlickerModel: Object, Mappable {
    
    @objc dynamic var photos: PhotosModel?
    @objc dynamic var stat: String? = ""
 
    
    
    
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
  
    
    
    public func mapping(map: Map){
        photos <- map["photos"]
        stat <- map["stat"]

        
        
    }
}





