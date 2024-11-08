//
//  MainViewController + Ext.swift
//  YourMeme

import UIKit

// MARK: - Working with keyboard
extension MainViewController {
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let keyboardResponder = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[keyboardResponder] as? NSValue
        else { return }
        
        let keyboardIsHidden = contentView.frame.origin.y == 0
        
        if keyboardIsHidden {
            contentView.frame.origin.y -= keyboardFrame.cgRectValue.height - 140
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let keyboardIsHidden = contentView.frame.origin.y == 0
        if !keyboardIsHidden {
            contentView.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


