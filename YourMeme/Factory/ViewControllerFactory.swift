//
//  ViewControllerFactory.swift
//  YourMeme

import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func createLoginScreen() -> LoginViewController
    func createRegisterScreen() -> RegisterViewController
    func createMainScreen() -> MainViewController
    func createListScreen() -> ListImagesViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    func createLoginScreen() -> LoginViewController {
        let authService = FirebaseService()
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view, authService: authService)
        view.presenter = presenter
        
        return view
    }
    
    func createRegisterScreen() -> RegisterViewController {
        let authService = FirebaseService()
        let view = RegisterViewController()
        let presenter = RegisterPresenter(view: view, authService: authService)
        view.presenter = presenter
        
        return view
    }
    
    func createMainScreen() -> MainViewController {
        let networkService = NetworkService_2()
        let authService = FirebaseService()
        let view = MainViewController()
        let presenter = MainPresenter_2(view: view, networkService: networkService, authService: authService)
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
