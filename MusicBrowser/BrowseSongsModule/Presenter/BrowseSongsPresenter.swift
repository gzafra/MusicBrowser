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
        
    }
    
    func viewNeedsUpdatedData() {
        
    }
    
    
}
