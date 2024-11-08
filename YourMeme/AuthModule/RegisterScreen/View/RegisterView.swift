//
//  RegisterView.swift
//  YourMeme

import UIKit

final class RegisterView: UIView {
    
    let emailTF = CustomAuthTextField(textFieldType: .email)
    let passwordTF = CustomAuthTextField(textFieldType: .password)
    let confirmTF = CustomAuthTextField(textFieldType: .confirmPassword)
    let registerButton = CustomAuthButtton(authType: .register)
    let passwordEyeButton = EyeButton()
    let confirmEyeButton = EyeButton()
    
    private lazy var authStackView = UIStackView(
        axis: .vertical,
        spacing: 15,
        arrangedSubviews: [emailTF, passwordTF, confirmTF, registerButton])
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmTF.delegate = self
        
        initialization()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set up Subviews
private extension RegisterView {
    
    func initialization() {
        setupViews()
        setConstraints()
        addButtonTargets()
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
        passwordTF.addSubview(passwordEyeButton)
        confirmTF.addSubview(confirmEyeButton)
        addSubview(authStackView)
    }
    
    func setConstraints() {
        [emailTF, passwordTF, confirmTF, passwordEyeButton, confirmEyeButton, registerButton, authStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            emailTF.heightAnchor.constraint(equalToConstant: 45),
            passwordTF.heightAnchor.constraint(equalToConstant: 45),
            confirmTF.heightAnchor.constraint(equalToConstant: 45),
            
            passwordEyeButton.centerYAnchor.constraint(equalTo: passwordTF.centerYAnchor),
            passwordEyeButton.trailingAnchor.constraint(equalTo: passwordTF.trailingAnchor, constant: -10),
            passwordEyeButton.widthAnchor.constraint(equalToConstant: 35),
            
            confirmEyeButton.centerYAnchor.constraint(equalTo: confirmTF.centerYAnchor),
            confirmEyeButton.trailingAnchor.constraint(equalTo: confirmTF.trailingAnchor, constant: -10),
            confirmEyeButton.widthAnchor.constraint(equalToConstant: 35),
            
            registerButton.heightAnchor.constraint(equalToConstant: 45),
            
            authStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            authStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }
    
    func addButtonTargets() {
        registerButton.addTarget(nil, action: #selector(RegisterViewController.registerButtonAction), for: .touchUpInside)
        passwordEyeButton.addTarget(nil, action: #selector(RegisterViewController.passwordEyeButtonAction(sender:)), for: .touchUpInside)
        confirmEyeButton.addTarget(nil, action: #selector(RegisterViewController.confirmEyeButtonAction(sender:)), for: .touchUpInside)
    }
}

// MARK: - UITextField Delegate
extension RegisterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            confirmTF.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }
}
