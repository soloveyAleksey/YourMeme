//
//  LoginViewController.swift
//  YourMeme

import UIKit

final class LoginViewController: UIViewController {
    
    private let contentView = LoginView()
    private let viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
    
    var presenter: LoginPresenterProtocol!
    
    // MARK: Override methods
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.emailTF.text = ""
        contentView.passwordTF.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Private methods
    private func setNavigationBar() {
        title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: @objc methods
    @objc func loginButtonAction() {
        contentView.loginButton.createButtonAnimation()
        
        guard let email = contentView.emailTF.text,
              let password = contentView.passwordTF.text,
              !email.isEmpty && !password.isEmpty
        else {
            presentAlert(title: .emptyField, .authentication)
            return
        }
        presenter.signIn(email, password)
    }
    
    @objc func eyeButtonAction(sender: UIButton) {
        contentView
            .eyeButton
            .toggleHideText(sender: sender, textField: contentView.passwordTF)
    }
    
    @objc func registerButtonAction() {
        let controller = viewControllerFactory.createRegisterScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func resetButtonAction() {
        presentResetPasswordAlert(.resetPassword) { [weak self] email in
            self?.presenter.resetPassword(email)
        }
    }
}

// MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func showMainScreen() {
        let controller = viewControllerFactory.createMainScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showAlert(with error: String) {
        presentAlert(.error, withError: error)
    }
    
    func showSuccessAlert() {
        presentAlert(title: .checkEmail, .successReset)
    }
    
    func showErrorVerifyAlert() {
        presentVerifyAlert(title: .error, .notVerifyEmail) {}
    }
}
