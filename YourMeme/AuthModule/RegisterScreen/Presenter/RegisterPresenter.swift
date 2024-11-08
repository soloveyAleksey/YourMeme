//
//  RegisterPresenter.swift
//  YourMeme

import Foundation

final class RegisterPresenter: RegisterPresenterProtocol {

    weak var view: RegisterViewProtocol?
    private let authService: FirebaseServiceProtocol
    
    init(view: RegisterViewProtocol, authService: FirebaseServiceProtocol) {
        self.view = view
        self.authService = authService
    }
    
    func createAccount(_ email: String, _ password: String) {
        
        Task { @MainActor in
            do {
                if try await authService.create(email, password) {
                    view?.showVerifyAlert()
                }
            } catch {
                view?.showAlert(with: error.localizedDescription)
            }
        }
    }
}
