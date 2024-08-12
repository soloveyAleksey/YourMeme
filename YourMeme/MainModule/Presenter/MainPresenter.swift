//
//  MainPresenter.swift
//  YourMeme

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var arrayFonts: [String] { get }
    var topUrl: String? { get }
    var bottomUrl: String? { get }
    var fontUrl: String? { get }
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
                view?.showAlert(with: error)
            }
        }
    }
    
    private func setupImage() {
        view?.startActivityIndicator()
        
        let urlImage = "https://ronreiter-meme-generator.p.rapidapi.com/meme?meme=\(currentMeme)&top=%20&bottom=%20"
        networkService.downloadImage(from: urlImage) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let image):
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
            case .success(let image):
                view?.setupImage(from: image)
                view?.stopActivityIndicator()
            case .failure(let error):
                view?.showAlert(with: error)
            }
        }
    }
}
