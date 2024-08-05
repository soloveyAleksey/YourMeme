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
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        self.layer.cornerRadius = 10
    }
}
