//
//  AuthModuleProtocols.swift
//  YourMeme

import Foundation

// MARK: - View
protocol LoginViewProtocol: AnyObject {
    func showMainScreen()
    func showAlert(with error: String)
    func showSuccessAlert()
    func showErrorVerifyAlert()
}

protocol RegisterViewProtocol: AnyObject {
    func showAlert(with error: String)
    func showVerifyAlert() 
}

// MARK: - Presenter
protocol LoginPresenterProtocol: AnyObject {
    func signIn(_ email: String, _ password: String)
    func resetPassword(_ email: String)
}

protocol RegisterPresenterProtocol: AnyObject {
    func createAccount(_ email: String, _ password: String)
}
