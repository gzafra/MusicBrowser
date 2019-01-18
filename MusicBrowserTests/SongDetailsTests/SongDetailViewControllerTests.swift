//
//  SongDetailViewControllerTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class SongDetailViewControllerTests: XCTestCase {

    private func setupEnvironment() -> (vc: SongDetailViewController, presenter: SongDetailPresenterProtocol)? {
        guard let dataSource = MockGenerator.mockSongListDataSource else { return nil }

        let vc = SongDetailRouter.setupModule(with: dataSource)
        guard let songDetailVC = vc as? SongDetailViewController else { return nil }

        return (vc: songDetailVC, presenter: songDetailVC.presenter)
    }
    
    
    func testBrowseSongsVC() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        environment.vc.viewDidLoad()
        
        testExpectation(description: "SongDetail VC didLoad", actionBlock: { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                
                XCTAssertNotNil(environment.vc.songTitleLabel.text)
                XCTAssertNotNil(environment.vc.artistNameLabel.text)
                expectation.fulfill()
            })
        }, waitFor: 10.0)
    }

}
