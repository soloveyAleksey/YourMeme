//
//  UIViewController + Ext.swift
//  YourMeme

import UIKit

extension UIViewController {
    
    func presentGenerateAlert() {
        let alertController = UIAlertController(
            title: "Error! Fields is Empty",
            message: "To generate, you need to fill in the fields at the Top or Bottom and the Font",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    func presentAlert(withError message: NetworkError) {
        let alertController = UIAlertController(
            title: "Received Error!",
            message: message.description,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}
