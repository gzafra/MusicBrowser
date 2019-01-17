//
//  Extensions.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest

extension XCTestCase {
    func testExpectation(description: String, actionBlock:(XCTestExpectation)->(), waitFor timeout: TimeInterval) {
        let expectation = self.expectation(description: description)
        actionBlock(expectation)
        waitForExpectations(timeout: timeout) { (error) in
            XCTAssertNil(error)
        }
    }
}
