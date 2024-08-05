//
//  UIImageView + Ext.swift
//  YourMeme

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage) {
        self.init()
        
        self.image = image
        self.contentMode = .scaleAspectFit
    }
}
