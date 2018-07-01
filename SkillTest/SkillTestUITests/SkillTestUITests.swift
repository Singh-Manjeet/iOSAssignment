//
//  SkillTestUITests.swift
//  SkillTestUITests
//
//  Created by Manjeet Singh on 29/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import XCTest
@testable import SkillTest

class SkillTestUITests: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
        print(app.debugDescription)
    }
    
    
    func testNumberOfRowsEqualsToFactsCountFromAPIResponse() {
        let tableView = app.tables.matching(identifier: Constants.tableAccessibilityIdentifier)
        
        var numberOfResults = 0
        APIClient.getFacts(url: APIConstants.baseUrl, onCompletion: { (isSuccessful, country) in
            guard let country = country,
                let facts = country.facts else {
                    XCTFail()
                    return
            }
            
            numberOfResults = facts.count
        })
        
        XCTAssertEqual(numberOfResults, tableView.cells.count)
    }
    
}
