//
//  SongDetailRouter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class SongDetailRouter: SongDetailRouterProtocol {
    static func setupModule() -> SongDetailViewInterface {
        // Init
        let interactor = SongDetailInteractor()
        let presenter = SongDetailPresenter(interactor: interactor)
        let router = SongDetailRouter()
        let viewInterface = SongDetailViewController(presenter: presenter, router: router)
        
        presenter.viewInterface = viewInterface
        
        return viewInterface
    }
    
    func navigateToNextSong() {
        
    }
    
    func navigatoToPrevSong() {
        
    }

}
