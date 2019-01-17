//
//  RequestManagerProtocol.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

protocol RequestManagerProtocol {
    func send<T: RequestProtocol>(request: T, after: TimeInterval)
    func send<T: RequestProtocol>(request: T)
}
