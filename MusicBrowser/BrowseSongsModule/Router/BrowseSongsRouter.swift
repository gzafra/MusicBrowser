//
//  BrowseSongsRouter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class BrowseSongsRouter {
    
}

extension BrowseSongsRouter: BrowseSongsRouterProtocol {
    static func setupModule() -> BrowseSongsViewInterface {
        // Init
        let interactor = BrowseSongsInteractor()
        let presenter = BrowseSongsPresenter(interactor: interactor)
        let router = BrowseSongsRouter()
        let viewInterface = BrowseSongsViewController(presenter: presenter, router: router)
        
        // Setup
        presenter.viewInterface = viewInterface
        
        return viewInterface
    }
    
    func navigateToSongDetail() {
        
    }
}
