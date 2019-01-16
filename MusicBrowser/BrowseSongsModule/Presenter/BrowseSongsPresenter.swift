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
    weak var viewInterface: BrowseSongsViewInterface?
    
    init(interactor: BrowseSongsInteractorProtocol) {
        self.interactor = interactor
    }
}

extension BrowseSongsPresenter: BrowseSongsPresenterProtocol {

    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let viewModel = BrowseSongsViewModel(songs: [
                SongViewModel(title: "First Song", artist: "Artist 1"),
                SongViewModel(title: "Second Song", artist: "Artist 1"),
                SongViewModel(title: "Third Song", artist: "Artist 2"),
                SongViewModel(title: "Awesome Song", artist: "Artist 2"),
                SongViewModel(title: "Nasty Song", artist: "Artist 2")
                ])
            self.viewInterface?.viewShouldUpdate(with: viewModel)
        }
    }
    
    func viewNeedsUpdatedData() {
        
    }
    
    
}
