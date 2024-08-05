//
//  ListPresenter.swift
//  YourMeme

import Foundation

protocol ListPresenterProtocol: AnyObject {
    var arrayMemes: [String] { get set }
}

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListImageViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let urlMemes = "https://ronreiter-meme-generator.p.rapidapi.com/images"
    
    var arrayMemes: [String] = []
    
    init(view: ListImageViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getListMemes(from: urlMemes) { [weak self] list in
            self?.arrayMemes = list.memes
            view.updateView()
        }
    }
    
    private func getListMemes(from url: String, completion: @escaping (ListModel) -> ()) {
        view?.startActivityIndicator()
        
        networkService.downloadList(from: url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                let list = ListModel(data: data)
                completion(list)
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error)
            }
        }
    }
}
