//
//  MainViewController.swift
//  YourMeme

import UIKit

protocol MainViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlert(with error: NetworkError)
    func setupImage(from data: ImageModel)
    func editText()
}

final class MainViewController: UIViewController {
    
    let contentView = MainView()
    var presenter: MainPresenter!
    
    private var selectedFont: String?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        loadingFont()
        addKeyboardObservers()
        removeKeyboardObservers()
    }
    
    // MARK: - Private methods
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearButtonAction))
        
        let plusImage = UIImage(systemName: "plus")
        let shareImage = UIImage(systemName: "square.and.arrow.up")
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: plusImage, style: .done, target: self, action: #selector(addButtonAction)),
            UIBarButtonItem(image: shareImage, style: .done, target: self, action: #selector(shareButtonAction))
        ]
    }
    
    private func loadingFont() {
        let fontPicker = UIPickerView()
        fontPicker.delegate = self
        fontPicker.backgroundColor = .systemBackground
        contentView.fontTF.inputView = fontPicker
    }
    
    private func setActivityViewController() {
        guard let image = contentView.memeImage.image else { return }
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    private func editText(from textField: UITextField) -> String? {
        return textField.text?.components(separatedBy: " ")
            .filter { !$0.isEmpty }.joined(separator: "%20")
    }
    
    // MARK: - @objc methods
    @objc private func clearButtonAction() {
        contentView.memeImage.image = UIImage(named: "jdun")
        contentView.activityIndicator.stopAnimating()
        contentView.topTF.text = nil
        contentView.bottomTF.text = nil
        contentView.fontTF.text = nil
    }
    
    @objc private func addButtonAction() {
        let controller = ViewControllerBuilder.createListScreen()
        navigationController?.pushViewController(controller, animated: true)
        
        controller.completion = { [weak self] meme in
            self?.presenter.currentMeme = meme
        }
    }
    
    @objc private func shareButtonAction() {
        setActivityViewController()
    }
    
    @objc func generateButtonAction() {
        presenter.generatingImage()
    }
}

// MARK: - MainView Protocol
extension MainViewController: MainViewProtocol {
    
    func startActivityIndicator() {
        contentView.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        contentView.activityIndicator.stopAnimating()
    }
     
    func showAlert(with error: NetworkError) {
        let alert = AlertController.showAlert(withError: error)
        present(alert, animated: true)
    }
    
    func setupImage(from data: ImageModel) {
        contentView.memeImage.image = UIImage(data: data.imageData)
    }
    
    func editText() {
        presenter.fontUrl = editText(from: contentView.fontTF)
        presenter.topUrl = editText(from: contentView.topTF)
        presenter.bottomUrl = editText(from: contentView.bottomTF)
    }
}

// MARK: - PickerView Data Sourse, Delegate
extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.arrayFont.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.arrayFont[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFont = presenter.arrayFont[row]
        contentView.fontTF.text = selectedFont
    }
}
