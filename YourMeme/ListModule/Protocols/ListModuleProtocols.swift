//
//  ListModuleProtocols.swift
//  YourMeme

import Foundation

// MARK: - View
protocol ListImageViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func updateView()
    func showAlert(with error: String)
}

// MARK: - Presenter
protocol ListPresenterProtocol: AnyObject {
    var arrayMemes: [String] { get }
    var filteredMemes: [String] { get }
    func filterContentForSearchText(_ searchText: String)
}
