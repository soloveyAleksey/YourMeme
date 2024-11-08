//
//  LoginPresenter.swift
//  YourMeme

import Foundation

final class LoginPresenter: LoginPresenterProtocol {

    weak var view: LoginViewProtocol?
    private let authService: FirebaseServiceProtocol
    
    init(view: LoginViewProtocol, authService: FirebaseServiceProtocol) {
        self.view = view
        self.authService = authService
    }
    
    func signIn(_ email: String, _ password: String) {
        Task { @MainActor in
            do {
                if try await authService.signIn(email, password) {
                    view?.showMainScreen()
                } else {
                    view?.showErrorVerifyAlert()
                }
            } catch {
                view?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func resetPassword(_ email: String) {
        Task { @MainActor in
            do {
                if try await authService.resetPassword(email) {
                    view?.showSuccessAlert()
                }
            } catch {
                view?.showAlert(with: error.localizedDescription)
            }
        }
    }
}
