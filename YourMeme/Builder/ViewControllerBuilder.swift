//
//  ViewControllerBuilder.swift
//  YourMeme

import Foundation

final class ViewControllerBuilder {
    
    static func createMainScreen() -> MainViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createListScreen() -> ListImagesViewController {
        let networkService = NetworkService()
        let view = ListImagesViewController()
        let presenter = ListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
