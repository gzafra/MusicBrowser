//
//  EndpointProtocol.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var baseUrl: String { get }
    var url: URL? { get }
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: baseUrl + self.rawValue)
        return urlComponents?.url
    }
}
