//
//  ViewControllerFactory.swift
//  YourMeme

import Foundation

protocol ViewControllerFactoryProtocol {
    func createMainScreen() -> MainViewController
    func createListScreen() -> ListImagesViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    func createMainScreen() -> MainViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    func createListScreen() -> ListImagesViewController {
        let networkService = NetworkService()
        let view = ListImagesViewController()
        let presenter = ListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
