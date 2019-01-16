//
//  SearchSongsEndpoints.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

/**
 Itunes API Search Songs Endpoints
 
 TODO: Should include these in the plist config as well as the Base URL
 */
enum ITunesEndpoints: String, EndpointProtocol {
    case search = "/search"
    
    
    var baseUrl: String {
        return "https://itunes.apple.com"
    }
}
