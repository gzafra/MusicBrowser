//
//  SongDetailViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController, SongDetailViewInterface {
    
    private enum Layout {
        static let topSpacing: CGFloat = 24
        static let middleSpacing: CGFloat = 12
        static let coverImageSize: CGFloat = UIScreen.main.bounds.size.width * 0.7
        
        static let iconSize: CGFloat = 60
    }
    
    var presenter: SongDetailPresenterProtocol
    var router: SongDetailRouterProtocol
    
    // MARK: - Outlets
    var songTitleLabel = UILabel()
    var artistNameLabel = UILabel()
    var coverImage = UIImageView()
    lazy var prevButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(Images.prevIcon.image, for: .normal)
        return button
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(Images.nextIcon.image, for: .normal)
        return button
    }()
    lazy var playButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(Images.playIcon.image, for: .normal)
        button.setImage(Images.pauseIcon.image, for: .selected)
        return button
    }()
    
    // MARK: - Lifecycle
    
    public init(presenter: SongDetailPresenterProtocol, router: SongDetailRouterProtocol) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        presenter.viewDidLoad()
    }
    
    private func commonInit() {
        view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []
        title = "Song Details"
        setupSongInfo()
        setupPlayer()
        setupLayout()
    }
    
    private func setupSongInfo() {
        view.addSubview(coverImage)
        songTitleLabel.numberOfLines = 0
        view.addSubview(songTitleLabel)
        view.addSubview(artistNameLabel)
    }
    
    private func setupPlayer() {
        view.addSubview(prevButton)
        view.addSubview(playButton)
        view.addSubview(nextButton)
        
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Horizontal
        songTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        prevButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: -90).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: 90).isActive = true
        
        // Vertical
        songTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.topSpacing).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: Layout.middleSpacing).isActive = true
        coverImage.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: Layout.middleSpacing).isActive = true
        playButton.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: Layout.middleSpacing).isActive = true
        prevButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        // Size
        songTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        coverImage.constraintSize(equalTo: CGSize(width: Layout.coverImageSize, height: Layout.coverImageSize))
        playButton.constraintSize(equalTo: CGSize(width: Layout.iconSize, height: Layout.iconSize))
        nextButton.constraintSize(equalTo: CGSize(width: Layout.iconSize, height: Layout.iconSize))
        prevButton.constraintSize(equalTo: CGSize(width: Layout.iconSize, height: Layout.iconSize))
    }
    
    
    // MARK: - SongDetailViewInterface
    
    func viewShouldUpdate(with viewModel: SongDetailViewModel) {
        songTitleLabel.text = viewModel.songTitle
        artistNameLabel.text = viewModel.songArtist
        coverImage.backgroundColor = .yellow
        
        prevButton.isEnabled = viewModel.hasPrev
        nextButton.isEnabled = viewModel.hasNext
        
        playButton.isSelected = viewModel.isPlaying
    }
    
    func showError(message: String) {
        UIAlertController.show(title: "Oops!", message: message, in: self)
    }

    // MARK: - Actions
    
    @objc func playTapped() {
        presenter.didAction(button: .play)
    }
    
    @objc func nextTapped() {
        presenter.didAction(button: .next)
    }
    
    @objc func prevTapped() {
        presenter.didAction(button: .prev)
    }
}
