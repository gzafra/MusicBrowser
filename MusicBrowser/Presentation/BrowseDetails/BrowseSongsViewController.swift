//
//  BrowseSongsViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class BrowseSongsViewController: UIViewController {
    
    // MARK: - Layout
    private enum Layout {
        static let searchBarHeight: CGFloat = 50.0
        static let sortBySelectorHeight: CGFloat = 30.0
    }
    
    
    // MARK: - Properties
    
    var presenter: BrowseSongsPresenterProtocol
    
    // Outlets
    private var tableView = UITableView()
    private var searchBar = UISearchBar()
    private var refreshControl = UIRefreshControl()
    lazy private var sortBySelector: UISegmentedControl = {
        let control = UISegmentedControl(items: [
            "Price", "Hander", "Mander"])
        return control
    }()
    internal var viewModel: BrowseSongsViewModel?

    // MARK: - Lifecycle
    public init(presenter: BrowseSongsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func commonInit() {
        view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []
        setupTableView()
        setupSearchBar()
        setupSortSelector()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: SongListCell.identifier, bundle: nil), forCellReuseIdentifier: SongListCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    private func setupSortSelector() {
        view.addSubview(sortBySelector)
        sortBySelector.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    }
    
    private func setupConstraints() {
        // Vertical
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: Layout.searchBarHeight).isActive = true
        sortBySelector.translatesAutoresizingMaskIntoConstraints = false
        searchBar.bottomAnchor.constraint(equalTo: sortBySelector.topAnchor).isActive = true
        sortBySelector.heightAnchor.constraint(equalToConstant: Layout.sortBySelectorHeight).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sortBySelector.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Horizontal
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sortBySelector.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sortBySelector.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        refreshControl.beginRefreshing()
        presenter.viewDidLoad()
    }
    
    @objc func indexChanged(_ sender: AnyObject) {
        switch sortBySelector.selectedSegmentIndex
        {
        case 0:
            break
        case 1:
            break
        default:
            break
        }
    }

}

// MARK: - Table View

extension BrowseSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SongListCell.identifier, for: indexPath) as! SongListCell
        
        guard let cellViewModel = viewModel?.songs[indexPath.row] else { return cell }
        cell.setup(with: cellViewModel)

        return cell
    }
}

// MARK: - Search

extension BrowseSongsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: Could schedule a search after N seconds
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchedString = searchBar.text else { return }
        presenter.userSearched(string: searchedString)
    }
}

// MARK: - Presentation

extension BrowseSongsViewController: BrowseSongsViewInterface {
    func viewShouldUpdate(with viewModel: BrowseSongsViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func showError(message: String) {
        UIAlertController.show(title: "Oops!", message: message, in: self)
    }
    
}
