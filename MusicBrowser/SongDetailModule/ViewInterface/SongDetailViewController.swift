//
//  SongDetailViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController, SongDetailViewInterface {
    var presenter: SongDetailPresenterProtocol
    var router: SongDetailRouterProtocol
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
        
    }
    
    
    // MARK: - SongDetailViewInterface
    
    func viewShouldUpdate(with viewModel: SongDetailViewModel) {
        
    }
    
    func showError(message: String) {
        
    }

}
