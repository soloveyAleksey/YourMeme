//
//  LoginView.swift
//  YourMeme

import UIKit

final class LoginView: UIView {
    
    let emailTF = CustomAuthTextField(textFieldType: .email)
    let passwordTF = CustomAuthTextField(textFieldType: .password)
    let loginButton = CustomAuthButtton(authType: .login)
    let eyeButton = EyeButton()
    private let regButton = UIButton(backgroundColor: .clear, titleColor: .systemBlue, title: "Register new account")
    private let resetButton = UIButton(backgroundColor: .clear, titleColor: .systemBlue, title: "Reset password?")
    
    private lazy var authStackView = UIStackView(
        axis: .vertical,
        spacing: 15,
        arrangedSubviews: [emailTF, passwordTF, loginButton])
    
    private lazy var bottomStackView = UIStackView(
        axis: .vertical,
        spacing: 3,
        arrangedSubviews: [regButton, resetButton])
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        initialization()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set up Views
private extension LoginView {
    
    func initialization() {
        setupViews()
        setConstraints()
        addButtonTargets()
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
        passwordTF.addSubview(eyeButton)
        addSubview(authStackView)
        addSubview(bottomStackView)
    }
    
    func setConstraints() {
        [emailTF, passwordTF, eyeButton, loginButton, authStackView, bottomStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            emailTF.heightAnchor.constraint(equalToConstant: 45),
            passwordTF.heightAnchor.constraint(equalToConstant: 45),
            
            eyeButton.centerYAnchor.constraint(equalTo: passwordTF.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTF.trailingAnchor, constant: -10),
            eyeButton.widthAnchor.constraint(equalToConstant: 35),
            
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            authStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            authStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }
    
    func addButtonTargets() {
        loginButton.addTarget(nil, action: #selector(LoginViewController.loginButtonAction), for: .touchUpInside)
        eyeButton.addTarget(nil, action: #selector(LoginViewController.eyeButtonAction(sender:)), for: .touchUpInside)
        regButton.addTarget(nil, action: #selector(LoginViewController.registerButtonAction), for: .touchUpInside)
        resetButton.addTarget(nil, action: #selector(LoginViewController.resetButtonAction), for: .touchUpInside)
    }
}

// MARK: - UITextField Delegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTF:
            passwordTF.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
}
