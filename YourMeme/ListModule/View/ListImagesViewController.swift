//
//  ListImagesViewController.swift
//  YourMeme

import UIKit

protocol ListImageViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func updateView()
    func showAlert(with error: NetworkError)
}

final class ListImagesViewController: UIViewController {
    
    private let cellID = "NameImagesCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var filteredMemes = [String]()
    private var isFiltering: Bool { searchController.isActive && !isSearchBarEmpty }
    private var isSearchBarEmpty: Bool { searchController.searchBar.text?.isEmpty ?? true }
    
    var presenter: ListPresenterProtocol!
    var completion: ((String) ->())?
    var currentMeme = "" {
        didSet {
            getCurrentMemsAndBack()
            navigationController?.popViewController(animated: true)
        }
    }
    
    private lazy var tableView: UITableView = {
        $0.rowHeight = 50
        $0.separatorInset.right = 16
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setNavigationBar()
    }
    
    // MARK: Private methods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        view.addSubview(activityIndicator)
        activityIndicator.center = tableView.center
    }
    
    private func setNavigationBar() {
        title = "List of Images"
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredMemes = presenter.arrayMemes.filter { (memes: String) -> Bool in
        return memes.lowercased().contains(searchText.lowercased())
        }
      tableView.reloadData()
    }
    
    private func getCurrentMemsAndBack() {
        completion?(currentMeme)
    }
}

// MARK: - ListImageView Protocol
extension ListImagesViewController: ListImageViewProtocol {
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
    func showAlert(with error: NetworkError) {
        let alert = AlertController.showAlert(withError: error)
        present(alert, animated: true)
    }
}

// MARK: - UITableView Data Source
extension ListImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredMemes.count : presenter.arrayMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var contentMems: String
        contentMems = isFiltering ? filteredMemes[indexPath.row] : presenter.arrayMemes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = contentMems
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension ListImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var memes = ""
        
        if let indexPath = tableView.indexPathForSelectedRow {
            memes = isFiltering ? filteredMemes[indexPath.row] : presenter.arrayMemes[indexPath.row]
        }
        self.currentMeme = memes
    }
}

// MARK: - UISearch Results Updating
extension ListImagesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
}
