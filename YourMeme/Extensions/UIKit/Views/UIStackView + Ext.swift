//
//  UIStackView + Ext.swift
//  YourMeme

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 10, arrangedSubviews: [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
