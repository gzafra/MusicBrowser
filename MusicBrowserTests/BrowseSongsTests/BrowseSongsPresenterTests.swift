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
    

    private func setupEnvironment() -> (presenter: BrowseSongsPresenter, mockVC: BrowseSongsViewInterfaceMock, router: BrowseSongsRouterMock) {
        let router = BrowseSongsRouterMock()
        let interactor = BrowseSongsInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.iTunesSearch))
        let presenter = BrowseSongsPresenter(interactor: interactor, router: router)
        
        let viewInterfaceMock = BrowseSongsViewInterfaceMock(presenter: presenter)
        presenter.viewInterface = viewInterfaceMock
        
        return (presenter: presenter, mockVC: viewInterfaceMock, router: router)
    }
    
    func testPresenterLoad() {
        let environment = setupEnvironment()
        
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(environment.mockVC.viewModel)
            XCTAssert(environment.mockVC.viewModel!.numberOfRows == 0)
            environment.presenter.userSearched(string: "Test")
            XCTAssert(environment.mockVC.viewModel!.numberOfRows > 0)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testCellSelected() {
        let environment = setupEnvironment()
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(environment.mockVC.viewModel)
            environment.presenter.userSearched(string: "Test")
            XCTAssert(environment.mockVC.viewModel!.numberOfRows > 0)
            environment.presenter.selectedCell(at: 0)
            XCTAssertNotNil(environment.router.dataSource)
            expectation.fulfill()
        }, waitFor: 2.0)
    }
    
    func testSortOptionSelected() {
        let environment = setupEnvironment()
        environment.presenter.viewDidLoad()
        
        testExpectation(description: "Presenter did load", actionBlock: { (expectation) in
            XCTAssertNotNil(environment.mockVC.viewModel)
            environment.presenter.userSearched(string: "Test")
            XCTAssert(environment.mockVC.viewModel!.numberOfRows > 0)
            environment.mockVC.viewModel = nil // Reset viewModel so that we know it was updated again
            let sortOption = SortOption(mode: .price, inverted: false)
            environment.presenter.sortOptionSelected(mode: sortOption)
            XCTAssertNotNil(environment.mockVC.viewModel)
  
            expectation.fulfill()
        }, waitFor: 2.0)
    }

}
