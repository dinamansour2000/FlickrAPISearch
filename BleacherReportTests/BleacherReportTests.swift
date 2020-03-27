//
//  BleacherReportTests.swift
//  BleacherReportTests
//
//  Created by Dina Mansour on 3/26/20.
//  Copyright © 2020 Andela. All rights reserved.
//

import UIKit
import XCTest
import Foundation
@testable import BleacherReport

// Protocol for MOCK/Real
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: HttpClient Implementation
class HttpClient {

    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session

    }

    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }

}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?

    private (set) var lastURL: URL?

    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url

        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
}


class BleacherReportTests: XCTestCase {

    var httpClient: HttpClient!
        let session = MockURLSession()

        func testCallToFlickr() {





            measure {
                // given
                guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=6a14aa646388c74944a1a8f736b4a971&format=json&nojsoncallback=1%E2%80%8B&text=test&page=1&per_page=25") else {
                    fatalError("URL can't be empty")
                }
                httpClient.get(url: url) { (success, response) in
                    // Return data
                }

                 XCTAssert(session.lastURL == url)
            }





        }

        override func setUp() {
            super.setUp()
            httpClient = HttpClient(session: session)
        }

        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
        }

        func testPerformanceExample() {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }

    }

