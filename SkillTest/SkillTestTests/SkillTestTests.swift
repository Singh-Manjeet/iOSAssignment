//
//  SkillTestTests.swift
//  SkillTestTests
//
//  Created by Manjeet Singh on 29/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import XCTest
@testable import SkillTest

/**
 * To test if the networking works appropriately
 * - All test cases can be extended further..
 */
class SkillTestTests: XCTestCase {
    
    func testCalback() {
        
        // 1. Setup the expectation
        let expectation = XCTestExpectation(description: "APIClient fetches data and succeeds")
        
        // 2. Exercise and verify the behaviour as usual
        APIClient.getFacts(url: APIConstants.baseUrl, onCompletion: { (isSuccessful, country) in
            XCTAssert(isSuccessful)
            expectation.fulfill()
        })
        
    }
    
    func testURLConnection() {
        let url = APIConstants.baseUrl
        let urlExpectation = expectation(description: "GET \(url)")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let mimeType = response.mimeType
            {
                
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, APIConstants.baseUrl.absoluteString)
                XCTAssertEqual(response.statusCode, 200, "Response status code should be 200")
                XCTAssertEqual(mimeType, "text/plain", "Response content type should be json/html")
                
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            urlExpectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
}
