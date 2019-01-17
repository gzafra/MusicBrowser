//
//  BrowseSongsPresenterTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class BrowseSongsPresenterTests: XCTestCase {
    let router = BrowseSongsRouterMock()
    let interactor = BrowseSongsInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.iTunesSearch))
    lazy var presenter = BrowseSongsPresenter(interactor: interactor, router: router)

    
    func testPresenterLoad() {
        let viewInterfaceMock = BrowseSongsViewInterfaceMock(presenter: presenter)
        presenter.viewInterface = viewInterfaceMock
        presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(viewInterfaceMock.viewModel)
            XCTAssert(viewInterfaceMock.viewModel!.numberOfRows == 0)
            presenter.userSearched(string: "Test")
            XCTAssert(viewInterfaceMock.viewModel!.numberOfRows > 0)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testCellSelected() {
        let viewInterfaceMock = BrowseSongsViewInterfaceMock(presenter: presenter)
        presenter.viewInterface = viewInterfaceMock
        presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(viewInterfaceMock.viewModel)
            presenter.userSearched(string: "Test")
            XCTAssert(viewInterfaceMock.viewModel!.numberOfRows > 0)
            presenter.selectedCell(at: 0)
            XCTAssertNotNil(router.dataSource)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testSortOptionSelected() {
        let viewInterfaceMock = BrowseSongsViewInterfaceMock(presenter: presenter)
        presenter.viewInterface = viewInterfaceMock
        presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(viewInterfaceMock.viewModel)
            presenter.userSearched(string: "Test")
            XCTAssert(viewInterfaceMock.viewModel!.numberOfRows > 0)
            viewInterfaceMock.viewModel = nil // Reset viewModel so that we know it was updated again
            let sortOption = SortOption(mode: .price, inverted: false)
            presenter.sortOptionSelected(mode: sortOption)
            XCTAssertNotNil(viewInterfaceMock.viewModel)
  
            expectation.fulfill()
        }, waitFor: 2.0)
    }

}
