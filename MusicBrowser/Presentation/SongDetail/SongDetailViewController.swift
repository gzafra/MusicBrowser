//
//  SongDetailViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit
import Kingfisher

class SongDetailViewController: UIViewController, SongDetailViewInterface {
    
    private enum Layout {
        static let topSpacing: CGFloat = 24
        static let middleSpacing: CGFloat = 12
        static let coverImageSize: CGFloat = UIScreen.main.bounds.size.width * 0.7
        
        static let iconSize: CGFloat = 60
        enum Margins {
            static let left: CGFloat = 12
            static let right: CGFloat = 12
        }
    }
    
    var presenter: SongDetailPresenterProtocol
    var router: SongDetailRouterProtocol
    
    // MARK: - Outlets
    var songTitleLabel = UILabel()
    var artistNameLabel = UILabel()
    lazy var coverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.didAction(button: .stop)
    }
    
    private func commonInit() {
        view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []
        title = LocalizedStrings.SongDetails.title
        setupShare()
        setupSongInfo()
        setupPlayer()
        setupLayout()
    }
    
    private func setupShare() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.shareIcon.image, style: .plain, target: self, action: #selector(shareButtonTapped))
    }
    
    private func setupSongInfo() {
        view.addSubview(coverImage)
        songTitleLabel.numberOfLines = 2
        songTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        songTitleLabel.textAlignment = .center
        view.addSubview(songTitleLabel)
        artistNameLabel.font = UIFont.systemFont(ofSize: 15)
        artistNameLabel.textColor = .gray
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
        view.addConstraintsWithFormat("H:|-(>=\(Layout.Margins.left))-[v0]-(>=\(Layout.Margins.left))-|", views: songTitleLabel) // Margins
        artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat("H:|-(>=\(Layout.Margins.left))-[v0]-(>=\(Layout.Margins.left))-|", views: artistNameLabel) // Margins
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
        
        coverImage.image = nil
        if let url = URL(string: viewModel.coverURL) {
            coverImage.kf.setImage(with: url)
        }
        
        prevButton.isEnabled = viewModel.hasPrev
        nextButton.isEnabled = viewModel.hasNext
        
        playButton.isSelected = viewModel.isPlaying
    }
    
    func showError(message: String) {
        UIAlertController.show(title: LocalizedStrings.Common.genericErrorTitle, message: message, in: self)
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
    
    @objc func shareButtonTapped() {
        let activityVC = UIActivityViewController(activityItems: [presenter.getShareContent()], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
