//
//  FlickerViewModel.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit


class FlickerViewModel: NSObject {
    lazy var backendManager = FlickerBackendManager();
   
    
    //
    //MARK: Network Request
    //
    public func getFlickerData(title: String, delegate: FlickerRequestDelegate) {

        
        backendManager.getFlickerData(title: title, delegate: delegate);
    }
    
    //
    // MARK: Cancel Network Request
    //
    func cancelFlickerDatatRequest() {
        backendManager.cancelFlickerDatatRequest()
    }
    

}


