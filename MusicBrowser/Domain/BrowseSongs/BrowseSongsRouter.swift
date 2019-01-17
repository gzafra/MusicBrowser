//
//  BrowseSongsRouter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class BrowseSongsRouter {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension BrowseSongsRouter: BrowseSongsRouterProtocol {
    
    
    static func setupModule(with navigationController: UINavigationController) -> BrowseSongsViewInterface {
        // Init
        let interactor = BrowseSongsInteractor()
        let router = BrowseSongsRouter(navigationController: navigationController)
        let presenter = BrowseSongsPresenter(interactor: interactor, router: router)
        let viewInterface = BrowseSongsViewController(presenter: presenter)

        presenter.viewInterface = viewInterface
        
        return viewInterface
    }
    
    func navigateToSongDetail(with dataSource: SongListDataSource) {
        guard let detailViewController = SongDetailRouter.setupModule(with: dataSource) as? UIViewController else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
