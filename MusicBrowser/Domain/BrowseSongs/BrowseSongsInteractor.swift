//
//  BrowseSongsInteractor.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

typealias SearchSongsCompletion = (SearchSongsResponse)->Void

class BrowseSongsInteractor: BrowseSongsInteractorProtocol {
    // MARK: - Private properties
    private let requestManager: RequestManagerProtocol
    fileprivate var songs: [SongData] = []
    private var currentSortMode: SortOption?
    
    // MARK: - Lifecycle
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    // MARK: - BrowseSongsInteractorProtocol
    
    func seachSongs(with terms: [String], successBlock: @escaping SearchSongsCompletion, failureBlock: @escaping () -> ()) {
        var request = SearchSongsRequest(terms: terms)
        request.completion = { result in
            switch result {
            case .success(let data):
                self.currentSortMode = nil
                self.songs = data.results
                successBlock(data)
            case .failure(_):
                failureBlock()
                break
            }
        }
        requestManager.send(request: request)
    }
    
    func getSongList(with selectedIndex: Int) -> SongListDataSource? {
        let dataSource = SongListDataSource(songs: songs, selectedIndex: selectedIndex)
        return dataSource
    }
    
    /// Sorts the data by the given parameter and returns the new data array
    func getSortedBy(sortOption: SortOption) -> [SongData] {
        currentSortMode = sortOption
        switch sortOption.mode {
        case .price:
            songs = songs.sorted{
                return sortOption.inverted ? $0.trackPrice < $1.trackPrice : $0.trackPrice > $1.trackPrice
            }
        case .length:
            songs = songs.sorted{
                return sortOption.inverted ? $0.trackTimeMillis < $1.trackTimeMillis : $0.trackTimeMillis > $1.trackTimeMillis
            }
        case .genre:
            songs = songs.sorted{
                return sortOption.inverted ? $0.primaryGenreName < $1.primaryGenreName : $0.primaryGenreName > $1.primaryGenreName
            }
        }
        
        return songs
    }
}
