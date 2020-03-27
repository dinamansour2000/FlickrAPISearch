//
//  RealmResultsExtensions.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [PhotoModel] {
        var array = [PhotoModel]()
        for result in self {
            array.append(result as! PhotoModel)
        }
        return array
    }
}
