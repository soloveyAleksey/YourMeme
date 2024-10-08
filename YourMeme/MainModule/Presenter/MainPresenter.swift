//
//  MainPresenter.swift
//  YourMeme

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var arrayFonts: [String] { get }
    var topUrl: String? { get set }
    var bottomUrl: String? { get set }
    var fontUrl: String? { get set }
    var currentMeme: String { get set }
    func generatingImage()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    var topUrl: String?
    var bottomUrl: String?
    var fontUrl: String?
    var arrayFonts: [String] = []
    
    var currentMeme = "" {
        didSet {
            setupImage()
        }
    }
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getListFonts()
    }
    
    // MARK: - Private Methods
    private func getListFonts() {
        view?.startActivityIndicator()
        
        let urlFonts = "https://ronreiter-meme-generator.p.rapidapi.com/fonts"
        networkService.downloadList(from: urlFonts) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let list):
                arrayFonts = list.listData
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error.description)
            }
        }
    }
    
    private func getImage(_ url: String) {
        view?.startActivityIndicator()
        
        networkService.downloadImage(from: url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let imageData):
                view?.setupImage(from: imageData)
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error.description)
            }
        }
    }
    
    private func setupImage() {
        let urlImage = "https://ronreiter-meme-generator.p.rapidapi.com/meme?meme=\(currentMeme)&top=%20&bottom=%20"
        getImage(urlImage)
    }
    
    // MARK: - Methods
    func generatingImage() {
        view?.editText()
        
        let urlCreateMeme = "https://ronreiter-meme-generator.p.rapidapi.com/meme?font=\(fontUrl ?? "")&font_size=50&meme=\(currentMeme)&top=\(topUrl ?? "")&bottom=\(bottomUrl ?? "")"
        getImage(urlCreateMeme)
    }
}
