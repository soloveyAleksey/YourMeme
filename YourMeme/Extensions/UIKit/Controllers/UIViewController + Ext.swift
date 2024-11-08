//
//  UIViewController + Ext.swift
//  YourMeme

import UIKit

extension UIViewController {
    
    func presentAlert(title: AlertTitle, _ message: AlertMessage) {
        let alertController = UIAlertController(
            title: title.rawValue,
            message: message.rawValue,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    func presentAlert(_ title: AlertTitle, withError message: String) {
        let alertController = UIAlertController(
            title: title.rawValue,
            message: message.description,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    func presentVerifyAlert(title: AlertTitle, _ message: AlertMessage, _ completion: @escaping () -> ()) {
        let alertController = UIAlertController(
            title: title.rawValue,
            message: message.rawValue,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    func presentResetPasswordAlert(_ message: AlertMessage, _ completion: @escaping (String) -> ()) {
        let alert = UIAlertController(
            title: "Reset Password",
            message: message.rawValue,
            preferredStyle: .alert)
        alert.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let okAction = UIAlertAction(title: "Reset", style: .default) { _ in
            guard let email = alert.textFields?.first?.text else { return }
            completion(email)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
