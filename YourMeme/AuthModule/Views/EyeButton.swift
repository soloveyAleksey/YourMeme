//
//  EyeButton.swift
//  YourMeme

import UIKit

final class EyeButton: UIButton {
    
    private var isPrivate = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        let image = UIImage(systemName: "eye")
        setImage(image, for: .normal)
        tintColor = .gray
    }
    
    func toggleHideText(sender: UIButton, textField: UITextField) {
        let imageName = isPrivate ? "eye.slash" : "eye"
        textField.isSecureTextEntry.toggle()
        isPrivate.toggle()
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
