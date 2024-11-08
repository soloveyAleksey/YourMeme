//
//  AuthTextField.swift
//  YourMeme

import UIKit

final class CustomAuthTextField: UITextField {
    
    enum TextFieldType: String {
        case email = "Email"
        case password = "Password"
        case confirmPassword = "Confirm password"
    }
    
    private let textFieldType: TextFieldType
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 60)
    
    // MARK: Initialization
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: .zero)
        
        configureTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // MARK: Private methods
    private func configureTextField() {
        backgroundColor = .white
        textColor = .systemBlue
        tintColor = .systemBlue
        
        layer.cornerRadius = 22.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
        
        attributedPlaceholder = NSAttributedString(
            string: textFieldType.rawValue,
            attributes: [.foregroundColor: UIColor.gray])
        font = UIFont.appleSDGothicNeoRegular(size: 21)
        
        autocorrectionType = .no
        
        switch textFieldType {
        case .email:
            keyboardType = .emailAddress
        case .password:
            isSecureTextEntry = true
        case .confirmPassword:
            isSecureTextEntry = true
        }
    }
}
