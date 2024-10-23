//
//  MainModuleProtocols.swift
//  YourMeme

import Foundation

// MARK: - View
protocol MainViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlert(with error: String)
    func setupImage(from data: ImageModel)
    func editText()
}

// MARK: - Presenter
protocol MainPresenterProtocol: AnyObject {
    var arrayFonts: [String] { get }
    var topUrl: String? { get set }
    var bottomUrl: String? { get set }
    var fontUrl: String? { get set }
    var currentMeme: String { get set }
    func generatingImage()
}
