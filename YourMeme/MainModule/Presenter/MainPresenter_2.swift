//
//  MainPresenter_2.swift
//  YourMeme

import Foundation

// MARK: A Presenter using NetworkService_2 async/await

final class MainPresenter_2: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol_2
    
    var topUrl: String?
    var bottomUrl: String?
    var fontUrl: String?
    var arrayFonts: [String] = []
    
    var currentMeme = "" {
        didSet {
            setupImage()
        }
    }
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol_2) {
        self.view = view
        self.networkService = networkService

        getListFonts()
    }
    
    // MARK: - Private Methods
    private func getListFonts() {
        view?.startActivityIndicator()
        
        let urlFonts = "https://ronreiter-meme-generator.p.rapidapi.com/fonts"
        
        Task { @MainActor in
            do {
                let listFonts = try await networkService.downloadList(from: urlFonts)
                arrayFonts = listFonts.listData
                view?.stopActivityIndicator()
            } catch {
                view?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func getImage(_ url: String) {
        view?.startActivityIndicator()
        
        Task { @MainActor in
            do {
                let imageData = try await networkService.downloadImage(from: url)
                view?.setupImage(from: imageData)
                view?.stopActivityIndicator()
            } catch {
                view?.showAlert(with: error.localizedDescription)
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
