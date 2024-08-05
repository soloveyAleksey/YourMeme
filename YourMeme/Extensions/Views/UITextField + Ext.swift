//
//  UITextField + Ext.swift
//  YourMeme

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, textAlignment: NSTextAlignment = .natural) {
        self.init()
        
        self.placeholder = placeholder
        self.textAlignment = textAlignment
        self.borderStyle = .roundedRect
        self.tintColor = .black
        self.autocorrectionType = .no
    }
}
