//
//  SongDetailPResenterTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class SongDetailPresenterTests: XCTestCase {
    
    private func setupEnvironment() -> (presenter: SongDetailPresenter, mockInteractor: SongDetailInteractorMock, mockVC: SongDetailViewInterfaceMock)? {

        let router = SongDetailRouter()
        let mockInteractor = SongDetailInteractorMock()
        let presenter = SongDetailPresenter(interactor: mockInteractor)
        let mockViewInterface = SongDetailViewInterfaceMock(presenter: presenter, router: router)
        presenter.viewInterface = mockViewInterface
        
        return (presenter: presenter, mockInteractor: mockInteractor, mockVC: mockViewInterface)
    }
    
    func testPresenterLoad() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        XCTAssertNil(environment.mockVC.viewModel)
        environment.presenter.viewDidLoad()
        XCTAssertNotNil(environment.mockVC.viewModel)
    }
    
    func testDidActionNext() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        XCTAssertNil(environment.mockVC.viewModel)
        environment.presenter.viewDidLoad()
        environment.mockVC.viewModel = nil
        environment.presenter.didAction(button: .next)
        XCTAssertNotNil(environment.mockVC.viewModel)
    }
    
    func testDidActionPlay() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        XCTAssertNil(environment.mockVC.viewModel)
        environment.presenter.viewDidLoad()
        environment.mockVC.viewModel = nil
        environment.presenter.didAction(button: .play)
        XCTAssertNotNil(environment.mockVC.viewModel)
        XCTAssert(environment.mockInteractor.isPlaying)
    }

}

