//
//  AuthButton.swift
//  YourMeme

import UIKit

final class CustomAuthButtton: UIButton {
    
    enum AuthButtonType: String {
        case login = "Login"
        case register = "Register"
    }
    
    private let authType: AuthButtonType
    
    // MARK: Initialization
    init(authType: AuthButtonType) {
        self.authType = authType
        super.init(frame: .zero)
        
        configureButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func configureButton() {
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        
        layer.cornerRadius = 22.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
        
        setTitle(authType.rawValue, for: .normal)
        titleLabel?.font = UIFont.appleSDGothicNeoSemiBold(size: 22)
    }
    
    // MARK: Methods
    func createButtonAnimation() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut) {
            
            self.bounds = CGRect(
                x: self.bounds.origin.x - 25,
                y: self.bounds.origin.y,
                width: self.bounds.width + 50,
                height: self.bounds.height)
            
            self.titleLabel?.bounds = CGRect(
                x: self.bounds.origin.x - 20,
                y: self.bounds.height / 2,
                width: self.bounds.width + 40,
                height: 0)
        }
    }
}
