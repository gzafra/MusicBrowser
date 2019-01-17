//
//  BrowseSongsRouterMock.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit
@testable import MusicBrowser

class BrowseSongsRouterMock: BrowseSongsRouterProtocol {
    static func setupModule(with navigationController: UINavigationController) -> BrowseSongsViewInterface {
        fatalError("Not implemented")
    }
    
    var dataSource: SongListDataSource?
    
    func navigateToSongDetail(with dataSource: SongListDataSource) {
        self.dataSource = dataSource
    }
    
    
}
