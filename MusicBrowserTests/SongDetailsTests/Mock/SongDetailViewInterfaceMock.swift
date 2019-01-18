//
//  SongDetailViewInterfaceMock.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

class SongDetailViewInterfaceMock: SongDetailViewInterface {
    var presenter: SongDetailPresenterProtocol
    var router: SongDetailRouterProtocol
    var viewModel: SongDetailViewModel?
    var errorShown: Bool = false
    
    init(presenter: SongDetailPresenterProtocol, router: SongDetailRouterProtocol) {
        self.presenter = presenter
        self.router = router
    }
    
    func viewShouldUpdate(with viewModel: SongDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func showError(message: String) {
        errorShown = true
    }
}
