//
//  SceneDelegate.swift
//  YourMeme

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
    private let authService: FirebaseServiceProtocol = FirebaseService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if authService.isLogin() {
            let rootViewController = viewControllerFactory.createMainScreen()
            window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        } else {
            let rootViewController = viewControllerFactory.createLoginScreen()
            window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        }
        window?.makeKeyAndVisible()
    }
}

