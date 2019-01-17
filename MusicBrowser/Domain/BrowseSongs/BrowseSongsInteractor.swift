//
//  BrowseSongsInteractor.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

typealias SearchSongsCompletion = (SearchSongsResponse)->Void

class BrowseSongsInteractor {
    // MARK: - Private properties
    private let requestManager: RequestManagerProtocol
    fileprivate var songs: [SongData] = []
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension BrowseSongsInteractor: BrowseSongsInteractorProtocol {
    func seachSongs(with terms: [String], successBlock: @escaping SearchSongsCompletion, failureBlock: @escaping () -> ()) {
        var request = SearchSongsRequest(terms: terms)
        request.completion = { result in
            switch result {
            case .success(let data):
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
}
