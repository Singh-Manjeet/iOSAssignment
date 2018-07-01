//
//  FactsViewModelTest.swift
//  SkillTestTests
//
//  Created by Manjeet Singh on 2/7/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import XCTest
@testable import SkillTest

class FactsViewModelTest: XCTestCase {

    func testIfViewModelReturnsAppropraiteDataState() {
        // 1. Setup the expectation
        let expectation = XCTestExpectation(description: "FactsViewModel fetches data and returns appropriate data state")
        
        // 2. Exercise and verify the behaviour as usual
        let factsViewModel = FactsViewModel()
        factsViewModel.getData { state in
            
            switch state {
            case .error:
                XCTFail()
            case .loaded(let container):
                XCTAssert(!container.facts.isEmpty)
                expectation.fulfill()
            default: break
            }
        }
    }
}
