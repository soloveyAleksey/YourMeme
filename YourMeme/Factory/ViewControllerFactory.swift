//
//  ViewControllerFactory.swift
//  YourMeme

import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func createMainScreen() -> MainViewController
    func createListScreen() -> ListImagesViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    func createMainScreen() -> MainViewController {
        let networkService = NetworkService_2()
        let view = MainViewController()
        let presenter = MainPresenter_2(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    func createListScreen() -> ListImagesViewController {
        let networkService = NetworkService_2()
        let view = ListImagesViewController()
        let presenter = ListPresenter_2(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
