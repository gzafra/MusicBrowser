//
//  SearchSongsRequest.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

struct SearchSongsRequest: RequestProtocol {
    
    typealias ResponseType = SearchSongsResponse
    var method: HTTPMethod = .get
    
    var url: URL? = ITunesEndpoints.search.url
    
    var completion: ((Result<SearchSongsResponse>) -> Void)?
    
    var queryString: [String : String]? {
        return ["term": terms.joined(separator: "+")]
    }
    
    let terms: [String]
    init(terms: [String]) {
        self.terms = terms
    }
}
