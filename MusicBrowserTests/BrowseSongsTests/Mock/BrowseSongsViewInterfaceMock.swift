//
//  BrowseSongsViewInterfaceMock.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

class BrowseSongsViewInterfaceMock: BrowseSongsViewInterface {
    var presenter: BrowseSongsPresenterProtocol
    var viewModel: BrowseSongsViewModel?
    var errorShown: Bool = false
    
    init(presenter: BrowseSongsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func viewShouldUpdate(with viewModel: BrowseSongsViewModel) {
        self.viewModel = viewModel
    }
    
    func showError(message: String) {
        errorShown = true
    }
    
    
}
