//
//  MockRequestManager.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

enum MockRequestManagerPromises {
    static let iTunesSearch = "iTunesSearch"
}

class MockRequestManager: RequestManagerProtocol {
    var shouldSucceed: Bool = true
    
    var promiseJson: String
    
    init(promiseJson: String) {
        self.promiseJson = promiseJson
    }
    
    func send<T>(request: T, after: TimeInterval) where T : RequestProtocol {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
            self.send(request: request)
        }
    }
    
    func send<T: RequestProtocol>(request: T) {
        if shouldSucceed {
            guard let jsonData = loadJson(withName: promiseJson),
                let decodedData = try? request.processResponseData(data: jsonData) else { return }
            request.completion?(.success(decodedData))
        }else{
            let error = ResultError.unknownError
            request.completion?(.failure(error))
        }
    }
    
    func loadJson(withName name: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
}
