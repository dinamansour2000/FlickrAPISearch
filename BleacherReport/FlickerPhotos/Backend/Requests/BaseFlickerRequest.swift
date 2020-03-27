//
//  BaseFlickerRequest.swift
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


public class BaseFlickerRequest<T: Mappable>: NSObject {
    
    let sessionManager = Alamofire.Session.default
    var dataRequest: DataRequest?
    var isForcingCancel = false
    
    
    public override init() {
        super.init()
    }

    
    public func getResponseObject(url: String, debugResponse: Bool = true) {
               sessionManager.request(url, method: getMethodType(), parameters: getParameters() , encoding: JSONEncoding.default ,headers: getHeaders())
                .debugLog()
                .responseObject(completionHandler: { (response: DataResponse<T, AFError>) in
                    if debugResponse {
                      //  Logger.info(response)
                    }
                    
                    weak var weakSelf = self
                    
                    switch response.result {
                        
                    case .success(let data) :
                        
                        weakSelf?.onRequestSuccess(data: data  )
                        
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        weakSelf?.onRequestFail()
                        
                    }
                })
        }
    
    func getMethodType() -> HTTPMethod {
        return .get
    }
    
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func onRequestSuccess(data: T?) {
        preconditionFailure("Override onRequestSuccess func -> BaseHomeRequest")
    }
    
    func onRequestFail() {
        preconditionFailure("Override onRequestFail func -> BaseHomeRequest")
    }
    
    
    func cancelRequest() {
        dataRequest?.cancel()
        isForcingCancel = true
    }
    
    func getParameters() -> Parameters? {
        return nil
    }
}




