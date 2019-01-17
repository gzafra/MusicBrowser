//
//  SongDetailProtocols.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol SongDetailInteractorProtocol: class {
    
}

protocol SongDetailPresenterProtocol: class {
    var interactor: SongDetailInteractorProtocol { get }
    var viewInterface: SongDetailViewInterface? { get set }
    func viewDidLoad()
}

protocol SongDetailViewInterface: class {
    var presenter: SongDetailPresenterProtocol { get set }
    var router: SongDetailRouterProtocol { get set }
    func viewShouldUpdate(with viewModel: SongDetailViewModel)
    func showError(message: String)
}

protocol SongDetailRouterProtocol: class {
    static func setupModule() -> SongDetailViewInterface
    func navigateToNextSong()
    func navigatoToPrevSong()
}
