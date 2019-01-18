//
//  SongDetailProtocols.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol SongDetailInteractorProtocol: class {
    func getCurrentSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?)
    func skipNextSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?)?
    func skipPreviousSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?)?
    func playSong()
    func stopSong()
    var delegate: SongDetailInteractorDelegate? { get set }
}

protocol SongDetailInteractorDelegate: class {
    func didChangeState(_ songState: SongState)
}

protocol SongDetailPresenterProtocol: class {
    var interactor: SongDetailInteractorProtocol { get }
    var viewInterface: SongDetailViewInterface? { get set }
    func viewDidLoad()
    func didAction(button: SongControlButton)
    func getShareContent() -> String
}

protocol SongDetailViewInterface: class {
    var presenter: SongDetailPresenterProtocol { get set }
    var router: SongDetailRouterProtocol { get set }
    func viewShouldUpdate(with viewModel: SongDetailViewModel)
    func showError(message: String)
}

protocol SongDetailRouterProtocol: class {
    static func setupModule(with dataSource: SongListDataSource) -> SongDetailViewInterface
}
