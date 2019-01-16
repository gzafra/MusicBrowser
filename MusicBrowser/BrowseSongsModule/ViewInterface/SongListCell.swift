//
//  SongListCell.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class SongListCell: UITableViewCell {
    static var identifier : String = "SongListCell"
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with viewModel: SongViewModel) {
        songTitleLabel.text = viewModel.title
        songArtistLabel.text = viewModel.artist
    }
    
}
