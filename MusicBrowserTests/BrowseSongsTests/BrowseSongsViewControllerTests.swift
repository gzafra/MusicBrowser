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
    
    private func setupEnvironment() -> (vc: BrowseSongsViewController, router: BrowseSongsRouterMock, presenter: BrowseSongsPresenter)? {
        let router = BrowseSongsRouterMock()
        let mockInteractor = BrowseSongsInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.iTunesSearch))
        let vc = BrowseSongsRouter.setupModule(with: UINavigationController())
        guard let browseSongsVC = vc as? BrowseSongsViewController else {
            return nil
        }
        let presenter = BrowseSongsPresenter(interactor: mockInteractor, router: router)
        browseSongsVC.presenter = presenter
        return (vc: browseSongsVC, router: router, presenter: presenter)
    }

    
    func testBrowseSongsVC() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }

        environment.vc.viewDidLoad()
        
        testExpectation(description: "Browse Songs VC didLoad", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                XCTAssertNotNil(environment.vc.tableView)
                XCTAssertGreaterThan(environment.vc.tableView.numberOfRows(inSection: 0), 0)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }

}
