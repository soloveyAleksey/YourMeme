//
//  MainView.swift
//  YourMeme

import UIKit

final class MainView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let memeImage = UIImageView(image: UIImage(named: "Zhdun"))
    let topTF = UITextField(placeholder: "Top text")
    let bottomTF = UITextField(placeholder: "Bottom text")
    let fontTF = UITextField(placeholder: "Select font")
    let generateButton = UIButton(title: "Generate")
    
    private lazy var vStack = UIStackView(
        axis: .vertical,
        arrangedSubviews: [topTF, bottomTF, fontTF])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topTF.delegate = self
        bottomTF.delegate = self
        
        setupViews()
        setDefaultImage()
        createToolBar()
        addButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setDefaultImage() {
        if memeImage.image == nil {
            memeImage.image = UIImage(named: "Zhdun")
        }
    }
    
    private func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(MainViewController.dismissKeyboard))
        toolbar.setItems([doneItem], animated: true)
        toolbar.isUserInteractionEnabled = true
        fontTF.inputAccessoryView = toolbar
    }
    
    private func addButtonTarget() {
        generateButton.addTarget(nil, action: #selector(MainViewController.generateButtonAction), for: .touchUpInside)
    }
}

// MARK: - Set up Views
private extension MainView {
    
    func setupViews() {
        backgroundColor = .systemGray6
        memeImage.addSubview(activityIndicator)
        [memeImage, vStack, generateButton].forEach { addSubview($0) }
        
        setConstraints()
    }
    
    func setConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        memeImage.translatesAutoresizingMaskIntoConstraints = false
        fontTF.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: memeImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: memeImage.centerYAnchor),
            
            memeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            memeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            memeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            memeImage.heightAnchor.constraint(equalToConstant: 400),
            
            vStack.topAnchor.constraint(equalTo: memeImage.bottomAnchor, constant: 20),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            generateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            generateButton.heightAnchor.constraint(equalToConstant: 40),
            generateButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
        ])
    }
}

// MARK: - UITextField Delegate
extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case topTF:
            bottomTF.becomeFirstResponder()
        case bottomTF:
            fontTF.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
        return true
    }
}
