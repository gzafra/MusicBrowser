//
//  BrowseSongsInteractor.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

typealias SearchSongsCompletion = (SearchSongsData)->Void

class BrowseSongsInteractor {
    // MARK: - Private properties
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension BrowseSongsInteractor: BrowseSongsInteractorProtocol {
    func seachSongs(successBlock: @escaping SearchSongsCompletion, failureBlock: @escaping () -> ()) {
        
    }
    
}
