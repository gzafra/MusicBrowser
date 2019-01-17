//
//  BrowseSongsRouter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class BrowseSongsRouter {
    
}

extension BrowseSongsRouter: BrowseSongsRouterProtocol {
    static func setupModule() -> BrowseSongsViewInterface {
        // Init
        let interactor = BrowseSongsInteractor()
        let router = BrowseSongsRouter()
        let presenter = BrowseSongsPresenter(interactor: interactor, router: router)
        let viewInterface = BrowseSongsViewController(presenter: presenter)

        presenter.viewInterface = viewInterface
        
        return viewInterface
    }
    
    func navigateToSongDetail(from navigationController: UINavigationController) {
        guard let detailViewController = SongDetailRouter.setupModule() as? UIViewController else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
