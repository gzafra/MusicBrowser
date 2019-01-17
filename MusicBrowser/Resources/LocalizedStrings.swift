//
//  LocalizedStrings.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

// TODO: Actually localise
enum LocalizedStrings {
    enum Common {
        static let genericErrorTitle = "Oops!"
        static let cancel = "Cancel"
    }
    enum BrowseSongs {
        static let title = "Browse Songs"
        static let couldNotSelect = "Could not select song"
        static let failedToLoad = "Failed to load song"
        
        static let sortByButton = "Sort by..."
        static let sortByTitle = "Sort By"
        static let sortByPriceAscending = "Price Ascending"
        static let sortByPriceDescending = "Price Descending"
        static let sortByGenre = "Genre"
        static let sortByLengthAscending = "Length Ascending"
        static let sortByLengthDescending = "Length Descending"
        static let sorted = "Sorted"
    }
    enum SongDetails {
        static let title = "Song Details"
    }
}
