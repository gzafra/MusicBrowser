//
//  UIImages.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

enum Images: String {
    case prevIcon = "prev"
    case nextIcon = "next"
    case playIcon = "play"
    case pauseIcon = "pause"
    case shareIcon = "share"
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
