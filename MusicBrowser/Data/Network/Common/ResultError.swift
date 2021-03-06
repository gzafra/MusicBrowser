//
//  ResultError.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

enum ResultError: Error {
    
    case serverError(code: HTTPCode)
    case unknownError
    case parsingError(message: String)
    case networkError(underlaying: Error)
    
}
