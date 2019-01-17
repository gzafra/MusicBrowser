//
//  BrowseSongsViewControllerTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class BrowseSongsViewControllerTests: XCTestCase {
    let router = BrowseSongsRouterMock()
    let mockInteractor = BrowseSongsInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.iTunesSearch))
    
    func testBrowseSongsVC() {
        let vc = BrowseSongsRouter.setupModule(with: UINavigationController())
        guard let browseSongsVC = vc as? BrowseSongsViewController else {
            XCTFail()
            return
        }
        
        browseSongsVC.presenter = BrowseSongsPresenter(interactor: mockInteractor, router: router)
        
        browseSongsVC.viewDidLoad()
        
        testExpectation(description: "RatesTVC didLoad", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                XCTAssertNotNil(browseSongsVC.tableView)
                XCTAssertGreaterThan(browseSongsVC.tableView.numberOfRows(inSection: 0), 0)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }

}
