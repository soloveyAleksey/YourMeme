//
//  AlertMessage.swift
//  YourMeme

import Foundation

enum AlertTitle: String {
    case error = "Received Error!"
    case emptyField = "Error! Fields is Empty"
    case checkEmail = "Check your email"
    case successRegister = "Registration is successful"
}

enum AlertMessage: String {
    case generate = "To generate, you need to fill in the fields at the Top or Bottom and the Font"
    case authentication = "To continue, you need to fill in all the fields"
    case successReset = "to continue resetting your password, go to your email"
    case resetPassword = "Enter the email address for the current profile"
    case verifyEmail = "Please check your email address and verify it"
    case notVerifyEmail = "Please verify your email address"
}
