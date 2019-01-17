//
//  SongListCell.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class SongListCell: UITableViewCell {
    static let identifier: String = "SongListCell"
    static let estimatedHeight: CGFloat = 122.0
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var songLengthLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var viewModel: SongViewModel? {
        didSet{
            songTitleLabel.text = viewModel?.title
            songArtistLabel.text = viewModel?.artist
            albumLabel.text = viewModel?.albumTitle
            releaseDateLabel.text = viewModel?.releaseDate
            genreLabel.text = viewModel?.genre
            priceLabel.text = viewModel?.price
        }
    }

    func setup(with viewModel: SongViewModel) {
        self.viewModel = viewModel
    }
    
    func beginLoadImage() {
        guard let urlString = viewModel?.coverThumbnailUrl, let url = URL(string: urlString) else { return }
        thumbnailImage.kf.setImage(with: url)
    }
    func cancelLoadImage() {
        thumbnailImage.kf.cancelDownloadTask()
    }
}
