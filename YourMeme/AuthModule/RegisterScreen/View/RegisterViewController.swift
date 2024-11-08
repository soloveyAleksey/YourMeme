//
//  RegisterViewController.swift
//  YourMeme

import UIKit

final class RegisterViewController: UIViewController {
    
    private var contentView = RegisterView()
    
    var presenter: RegisterPresenterProtocol!
    
    // MARK: Override methods
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Private methods
    private func setNavigationBar() {
        title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: @objc Methods
    @objc func registerButtonAction() {
        contentView.registerButton.createButtonAnimation()
        
        guard let email = contentView.emailTF.text,
              let password = contentView.passwordTF.text,
              let confirm = contentView.confirmTF.text,
              !email.isEmpty && !password.isEmpty && !confirm.isEmpty && password == confirm
        else {
            presentAlert(title: .emptyField, .authentication)
            return
        }
        presenter.createAccount(email, password)
    }
    
    @objc func passwordEyeButtonAction(sender: UIButton) {
        contentView
            .passwordEyeButton
            .toggleHideText(sender: sender, textField: contentView.passwordTF)
    }
    
    @objc func confirmEyeButtonAction(sender: UIButton) {
        contentView
            .passwordEyeButton
            .toggleHideText(sender: sender, textField: contentView.confirmTF)
    }
}

// MARK: - RegisterViewProtocol
extension RegisterViewController: RegisterViewProtocol {
    
    func showAlert(with error: String) {
        presentAlert(.error, withError: error)
    }
    
    func showVerifyAlert() {
        presentVerifyAlert(title: .successRegister, .verifyEmail) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
