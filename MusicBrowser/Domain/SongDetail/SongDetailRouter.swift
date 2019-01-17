//
//  SongDetailRouter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class SongDetailRouter: SongDetailRouterProtocol {
    static func setupModule(with dataSource: SongListDataSource) -> SongDetailViewInterface {

        let interactor = SongDetailInteractor(dataSource: dataSource)
        let presenter = SongDetailPresenter(interactor: interactor)
        interactor.delegate = presenter
        let router = SongDetailRouter()
        let viewInterface = SongDetailViewController(presenter: presenter, router: router)
        
        presenter.viewInterface = viewInterface
        
        return viewInterface
    }

}
