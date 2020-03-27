//
//  FlickerRequest.swift
//  BleacherReport
//
//  Created by Dina Mansour on 3/27/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper


public protocol FlickerRequestDelegate: NSObjectProtocol {
    func requestWillSend()
    
    func requestSucceeded(data: FlickerModel?)
    
    func requestFailed()
}

class FlickerRequest: BaseFlickerRequest<FlickerModel> {
    
    weak var delegate: FlickerRequestDelegate?

    
    public override init() {
        super.init()
    }
    
    public func getFlickerData(title: String){
        delegate?.requestWillSend()
        getResponseObject(url: FlickerConstant.FLICKER_URL + title + "&page=1&per_page=25", debugResponse: false)
    }
    
    override func onRequestSuccess(data: FlickerModel?) {
        delegate?.requestSucceeded(data: data)

    }
    
    override func onRequestFail() {
        delegate?.requestFailed()
    }
    
    
}





