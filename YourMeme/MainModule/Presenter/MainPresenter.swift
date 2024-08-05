//
//  MainPresenter.swift
//  YourMeme

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var arrayFont: [String] { get set }
    var topUrl: String? { get set }
    var bottomUrl: String? { get set }
    var fontUrl: String? { get set }
    func generatingImage()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let urlFonts = "https://ronreiter-meme-generator.p.rapidapi.com/fonts"
    
    var topUrl: String?
    var bottomUrl: String?
    var fontUrl: String?
    var arrayFont: [String] = []
    
    var currentMeme = "" {
        didSet {
            setupImage()
        }
    }
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getListFonts(from: urlFonts) { [weak self] list in
            self?.arrayFont = list.fonts
        }
    }

    private func getListFonts(from url: String, completion: @escaping (FontListModel) -> ()) {
        networkService.downloadList(from: urlFonts) { [weak self] result in
            
            switch result {
            case .success(let data):
                let list = FontListModel(data: data)
                completion(list)
            case .failure(let error):
                self?.view?.showAlert(with: error)
            }
        }
    }
    
    private func setupImage() {
        let urlImage = "https://ronreiter-meme-generator.p.rapidapi.com/meme?meme=\(currentMeme)&top=%20&bottom=%20"
        view?.startActivityIndicator()
        
        networkService.downloadImage(from: urlImage) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                let image = ImageModel(data: data)
                view?.setupImage(from: image)
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error)
            }
        }
    }
    
    func generatingImage() {
        view?.editText()
        view?.startActivityIndicator()
        
        let urlCreateMeme = "https://ronreiter-meme-generator.p.rapidapi.com/meme?font=\(fontUrl ?? "")&font_size=50&meme=\(currentMeme)&top=\(topUrl ?? "")&bottom=\(bottomUrl ?? "")"
        networkService.downloadImage(from: urlCreateMeme) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                let image = ImageModel(data: data)
                view?.setupImage(from: image)
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error)
            }
        }
    }
}
