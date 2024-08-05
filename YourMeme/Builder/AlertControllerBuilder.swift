//
//  AlertControllerBuilder.swift
//  YourMeme

import UIKit

final class AlertController {
    
    static func showAlert(withError massage: NetworkError) -> UIAlertController {
        let alert = UIAlertController(
            title: "Received Error",
            message: massage.description,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        return alert
    }
}
