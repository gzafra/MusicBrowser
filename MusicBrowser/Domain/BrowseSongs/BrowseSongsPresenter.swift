//
//  BrowseSongsPresenter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class BrowseSongsPresenter: BrowseSongsPresenterProtocol {
    
    var interactor: BrowseSongsInteractorProtocol
    var router: BrowseSongsRouterProtocol
    weak var viewInterface: BrowseSongsViewInterface?
    
    init(interactor: BrowseSongsInteractorProtocol, router: BrowseSongsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - BrowseSongsPresenterProtocol
    func viewDidLoad() {
        viewInterface?.viewShouldUpdate(with: generateSongsViewModel(for: []))
    }
    
    func userSearched(string: String) {
        let terms: [String] = string.components(separatedBy: [" ", ","])
        interactor.seachSongs(with: terms, successBlock: { [weak self] (response) in
            guard let self = self else { return }
            let viewModel = self.generateSongsViewModel(for: response.results)
            self.viewInterface?.viewShouldUpdate(with: viewModel)
        }) { [weak self] in
            self?.viewInterface?.showError(message: LocalizedStrings.BrowseSongs.failedToLoad)
        }
    }
    
    func selectedCell(at index: Int) {
        guard let datasource = interactor.getSongList(with: index) else {
            viewInterface?.showError(message: LocalizedStrings.BrowseSongs.couldNotSelect)
            return
        }
        router.navigateToSongDetail(with: datasource)
    }
    
    private func generateSongsViewModel(for data: [SongData]) -> BrowseSongsViewModel {
        
        let songs = data.map{ song in
            return SongViewModel(title: song.trackName,
                                 artist: song.artistName,
                                 albumTitle: song.collectionName ?? "",
                                 releaseDate: DateFormatterHelper.formattedString(from: song.releaseDate),
                                 coverThumbnailUrl: song.artworkUrl60,
                                 songLength: NumberFormatterHelper.format(length: song.trackTimeMillis),
                                 genre: song.primaryGenreName,
                                 price: NumberFormatterHelper.format(rate: song.trackPrice, currencySymbol: "$"))
        }
        return BrowseSongsViewModel(songs: songs)
    }
    
    func sortOptionSelected(mode: SortOption) {
        let viewModel = generateSongsViewModel(for: interactor.getSortedBy(sortOption: mode))
        viewInterface?.viewShouldUpdate(with: viewModel)
    }
}
