//
//  BrowseSongsProtocols.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

protocol BrowseSongsInteractorProtocol: class {
    func seachSongs(with terms: [String], successBlock: @escaping SearchSongsCompletion, failureBlock: @escaping () -> ()) 
}

protocol BrowseSongsPresenterProtocol: class {
    var interactor: BrowseSongsInteractorProtocol { get }
    var viewInterface: BrowseSongsViewInterface? { get set }
    var router: BrowseSongsRouterProtocol { get }
    
    func viewDidLoad()
    func userSearched(string: String)
    func selectedCell(at index: Int)
}

protocol BrowseSongsViewInterface: class {
    var presenter: BrowseSongsPresenterProtocol { get set }
    func viewShouldUpdate(with viewModel: BrowseSongsViewModel)
    func showError(message: String)
}

protocol BrowseSongsRouterProtocol: class {
    static func setupModule() -> BrowseSongsViewInterface
    func navigateToSongDetail(from navigationController: UINavigationController)
}
