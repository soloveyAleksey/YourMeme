//
//  ListPresenter_2.swift
//  YourMeme

import Foundation

// MARK: A Presenter using NetworkService_2 async/await

final class ListPresenter_2: ListPresenterProtocol {
    
    weak var view: ListImageViewProtocol?
    private let networkService: NetworkServiceProtocol_2
    
    var arrayMemes: [String] = []
    var filteredMemes: [String] = []
    
    init(view: ListImageViewProtocol, networkService: NetworkServiceProtocol_2) {
        self.view = view
        self.networkService = networkService
        
        getListMemes()
    }
    
    private func getListMemes() {
        view?.startActivityIndicator()
        let urlMemes = "https://ronreiter-meme-generator.p.rapidapi.com/images"
        
        Task { @MainActor in
            do {
                let listMemes = try await networkService.downloadList(from: urlMemes)
                arrayMemes = listMemes.listData

                view?.updateView()
                view?.stopActivityIndicator()
            } catch {
                view?.showAlert(with: error.localizedDescription)
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
