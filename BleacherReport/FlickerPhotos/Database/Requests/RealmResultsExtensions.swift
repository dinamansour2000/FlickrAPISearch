//
//  RealmResultsExtensions.swift
//  Movies
//
//  Created by Dina Mansour on 6/6/19.
//  Copyright © 2019 SWVL. All rights reserved.
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
