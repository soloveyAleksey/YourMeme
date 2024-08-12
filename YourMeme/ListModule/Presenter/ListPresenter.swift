//
//  ListPresenter.swift
//  YourMeme

import Foundation

protocol ListPresenterProtocol: AnyObject {
    var arrayMemes: [String] { get }
    var filteredMemes: [String] { get }
    func filterContentForSearchText(_ searchText: String)
}

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListImageViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    var arrayMemes: [String] = []
    var filteredMemes = [String]()
    
    init(view: ListImageViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService

        getListMemes()
    }
    
    private func getListMemes() {
        view?.startActivityIndicator()
        
        let urlMemes = "https://ronreiter-meme-generator.p.rapidapi.com/images"
        networkService.downloadList(from: urlMemes) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let list):
                arrayMemes = list.listData
                view?.updateView()
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error)
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMemes = arrayMemes.filter { (memes: String) -> Bool in
            return memes.lowercased().contains(searchText.lowercased())
        }
        view?.updateView()
    }
}
