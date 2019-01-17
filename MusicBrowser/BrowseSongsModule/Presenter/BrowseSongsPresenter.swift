//
//  BrowseSongsPresenter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class BrowseSongsPresenter {
    var interactor: BrowseSongsInteractorProtocol
    var router: BrowseSongsRouterProtocol
    weak var viewInterface: BrowseSongsViewInterface?
    
    init(interactor: BrowseSongsInteractorProtocol, router: BrowseSongsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension BrowseSongsPresenter: BrowseSongsPresenterProtocol {

    func viewDidLoad() {
        // TODO: Show empty view, preloaded data, ...
    }
    
    func userSearched(string: String) {
        let terms: [String] = string.components(separatedBy: [" ", ","])
        interactor.seachSongs(with: terms, successBlock: { [weak self] (response) in
            guard let self = self else { return }
            let viewModel = self.generateSongsViewModel(for: response)
            self.viewInterface?.viewShouldUpdate(with: viewModel)
        }) { [weak self] in
            self?.viewInterface?.showError(message: "Failed to load data")
        }
    }
    
    func selectedCell(at index: Int) {
        
    }
    
    private func generateSongsViewModel(for data: SearchSongsResponse) -> BrowseSongsViewModel {
        
        let songs = data.results.map{ song in
            return SongViewModel(title: song.trackName, artist: song.artistName)
        }
        return BrowseSongsViewModel(songs: songs)
    }
    
}
