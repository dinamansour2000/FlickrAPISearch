//
//  FlickerBackendManager.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit

class FlickerBackendManager: NSObject {
    
  
    
    lazy var flickerRequest = FlickerRequest()
    
    public func getFlickerData(title: String, delegate: FlickerRequestDelegate) {
        flickerRequest.delegate = delegate
        flickerRequest.getFlickerData(title: title)
    }
    
    func cancelFlickerDatatRequest() {
        flickerRequest.cancelRequest()
    }
    
}
