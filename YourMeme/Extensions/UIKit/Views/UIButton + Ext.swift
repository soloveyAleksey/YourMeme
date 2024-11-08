//
//  UIButton + Ext.swift
//  YourMeme

import UIKit

extension UIButton {
    
    convenience init(backgroundColor: UIColor = .systemBlue, titleColor: UIColor = .white, title: String) {
        self.init(type: .system)
        
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.appleSDGothicNeoRegular(size: 20)
        self.layer.cornerRadius = 10
    }
}
