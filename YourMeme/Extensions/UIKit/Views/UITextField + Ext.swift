//
//  UITextField + Ext.swift
//  YourMeme

import UIKit

extension UITextField {
    
    convenience init(placeholder: String) {
        self.init()
        
        self.placeholder = placeholder
        self.textAlignment = .center
        self.borderStyle = .roundedRect
        self.tintColor = .black
        self.autocorrectionType = .no
    }
}
