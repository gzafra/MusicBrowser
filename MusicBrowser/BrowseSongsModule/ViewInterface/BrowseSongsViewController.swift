//
//  BrowseSongsViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class BrowseSongsViewController: UIViewController {
    var presenter: BrowseSongsPresenterProtocol
    var router: BrowseSongsRouterProtocol
    
    // Outlets
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var searchBar = UISearchBar(frame: .zero)
    private var refreshControl = UIRefreshControl()
    internal var viewModel: BrowseSongsViewModel?

    // MARK: - Lifecycle
    public init(presenter: BrowseSongsPresenterProtocol, router: BrowseSongsRouterProtocol) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func commonInit() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(SongListCell.self, forCellReuseIdentifier: SongListCell.identifier)
        view.addSubview(tableView)
        
        
    }
    
    private func setupSearchBar() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.beginRefreshing()
        presenter.viewDidLoad()
    }

}

extension BrowseSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension BrowseSongsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongListCell.identifier, for: indexPath)
        
        guard let cellViewModel = viewModel?.songs[indexPath.row] else { return cell }

        // TODO: Generate cell with view model data
        return cell
    }
}

extension BrowseSongsViewController: BrowseSongsViewInterface {
    func viewShouldUpdate(with viewModel: BrowseSongsViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
}
