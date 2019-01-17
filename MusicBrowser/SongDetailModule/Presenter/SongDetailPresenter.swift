//
//  SongDetailPresenter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class SongDetailPresenter: SongDetailPresenterProtocol {
    var interactor: SongDetailInteractorProtocol
    var viewInterface: SongDetailViewInterface?
    
    // MARK: - Lifecycle
    
    init(interactor: SongDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        
    }
}
