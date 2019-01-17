//
//  BrowseSongsViewController.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class BrowseSongsViewController: UIViewController, BrowseSongsViewInterface, LoadingViewController {
    
    // MARK: - Layout
    private enum Layout {
        static let searchBarHeight: CGFloat = 50.0
        static let sortBySelectorHeight: CGFloat = 30.0
        static let sortBySelectorRightPadding: CGFloat = -24
    }
    
    
    // MARK: - Properties
    
    var presenter: BrowseSongsPresenterProtocol
    
    // Outlets
    internal var tableView = UITableView()
    private var searchBar = UISearchBar()
    internal var loadingView = LoadingView(frame: .zero)
    lazy private var sortByButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.BrowseSongs.sortByButton, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.isEnabled = false
        return button
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
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        title = LocalizedStrings.BrowseSongs.title
        
        // Others
        setupTableView()
        setupSearchBar()
        setupSortSelector()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        tableView.register(UINib(nibName: SongListCell.identifier, bundle: nil), forCellReuseIdentifier: SongListCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
    }
    
    private func setupSortSelector() {
        view.addSubview(sortByButton)
        sortByButton.addTarget(self, action: #selector(sortByTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // Vertical
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: Layout.searchBarHeight).isActive = true
        sortByButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.bottomAnchor.constraint(equalTo: sortByButton.topAnchor).isActive = true
        sortByButton.heightAnchor.constraint(equalToConstant: Layout.sortBySelectorHeight).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sortByButton.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Horizontal
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sortByButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Layout.sortBySelectorRightPadding).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()

        beginLoading()
        presenter.viewDidLoad()
    }
    
    // MARK: - BrowseSongsViewInterface
    
    func viewShouldUpdate(with viewModel: BrowseSongsViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        endLoading()
        sortByButton.isEnabled = viewModel.numberOfRows > 0
    }
    
    func showError(message: String) {
        endLoading()
        UIAlertController.show(title: LocalizedStrings.Common.genericErrorTitle, message: message, in: self)
    }

    // MARK: - Sorting
    
    @objc func sortByTapped() {
        let sortAlertController = UIAlertController(title: LocalizedStrings.BrowseSongs.sortByTitle, message: nil, preferredStyle: .actionSheet)
        let priceAscendingAction = UIAlertAction(title: LocalizedStrings.BrowseSongs.sortByPriceAscending, style: .default) { [weak self] _ in
            let option = SortOption(mode: .price, inverted: false )
            self?.presenter.sortOptionSelected(mode: option)
            self?.setupSortOptionButton(for: option)
        }
        let priceDescendingAction = UIAlertAction(title: LocalizedStrings.BrowseSongs.sortByPriceDescending, style: .default) { [weak self] _ in
            let option = SortOption(mode: .price, inverted: true )
            self?.presenter.sortOptionSelected(mode: option)
            self?.setupSortOptionButton(for: option)
        }
        let genreAction = UIAlertAction(title: LocalizedStrings.BrowseSongs.sortByGenre, style: .default) { [weak self] _ in
            let option = SortOption(mode: .genre, inverted: false )
            self?.presenter.sortOptionSelected(mode: option)
            self?.setupSortOptionButton(for: option)
        }
        let lengthAscendingAction = UIAlertAction(title: LocalizedStrings.BrowseSongs.sortByLengthAscending, style: .default) { [weak self] _ in
            let option = SortOption(mode: .length, inverted: false )
            self?.presenter.sortOptionSelected(mode: option)
            self?.setupSortOptionButton(for: option)
        }
        let lengthDescendingAction = UIAlertAction(title: LocalizedStrings.BrowseSongs.sortByLengthDescending, style: .default) { [weak self] _ in
            let option = SortOption(mode: .length, inverted: true )
            self?.presenter.sortOptionSelected(mode: option)
            self?.setupSortOptionButton(for: option)
        }
        
        let cancelAction = UIAlertAction(title: LocalizedStrings.Common.cancel, style: .cancel, handler: nil)
        
        sortAlertController.addAction(priceAscendingAction)
        sortAlertController.addAction(priceDescendingAction)
        sortAlertController.addAction(lengthAscendingAction)
        sortAlertController.addAction(lengthDescendingAction)
        sortAlertController.addAction(genreAction)
        sortAlertController.addAction(cancelAction)
        self.present(sortAlertController, animated: true, completion: nil)
    }
    
    private func setupSortOptionButton(for option: SortOption?) {
        if let _ = option {
            sortByButton.isSelected = true
            sortByButton.setTitle(LocalizedStrings.BrowseSongs.sorted, for: .selected)
        }else{
            sortByButton.isSelected = false
        }
    }
}

// MARK: - Table View

extension BrowseSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SongListCell.estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectedCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? SongListCell)?.beginLoadImage()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? SongListCell)?.cancelLoadImage()
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
        beginLoading()
        setupSortOptionButton(for: nil) // Reset sort option
        presenter.userSearched(string: searchedString)
    }
}
