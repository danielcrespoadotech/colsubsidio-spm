//
//  ValidateViewController.swift
//  SMSDK
//
//  Created by Daniel Crespo on 17/10/22.
//

import UIKit

protocol ValidateViewControllerProtocol: AnyObject {
    func nextScreenFaceViewController(delegate: SMDelegate, params: SMParams)
}

class ValidateViewController: UIViewController {
    
    private struct Constants {
        static let title = "Valida tu identidad"
        static let paragraph = "Por tu seguridad vamos a escanear tu rostro.\n\nPrepárate para tu reconocimiento facial.\n\nAsegúrate de contar con buena iluminación en tu rostro y retira elementos como gafas, gorra, audífonos o cualquier objeto que impida ver tu cara."
        static let titleButton = "Tomar la foto"
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: ConstantsUi.Font.semiBold, size: 26)
        titleLabel.textColor = ConstantsUi.Colors.black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var paragraphLabel: UILabel = {
        let paragraphLabel = UILabel()
        paragraphLabel.numberOfLines = 0
        paragraphLabel.textAlignment = .left
        paragraphLabel.font = UIFont(name: ConstantsUi.Font.regular, size: 16)
        paragraphLabel.textColor = ConstantsUi.Colors.black
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        return paragraphLabel
    }()
    
    private lazy var iconValidateIdImageView: UIImageView = {
        let iconValidateIdImageView = UIImageView()
        iconValidateIdImageView.contentMode = .scaleAspectFit
        iconValidateIdImageView.image = ConstantsUi.Images.iconValidateId
        iconValidateIdImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconValidateIdImageView
    }()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.titleLabel?.font = UIFont(name: ConstantsUi.Font.regular, size: 20)
        startButton.layer.cornerRadius = 6.0
        startButton.backgroundColor = ConstantsUi.Colors.blue
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    private var delegate: SMDelegate?
    private var params: SMParams?
    weak var coordinator: ValidateViewControllerProtocol?
    
    init(delegate: SMDelegate, params: SMParams) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.params = params
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        setupView()
        setupUi()
    }
    
    private func setupView() {
        setupContentView()
        setupStartButton()
        setupStackView()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(paragraphLabel)
        stackView.addArrangedSubview(iconValidateIdImageView)
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: margins.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    private func setupStartButton() {
        contentView.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            startButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            startButton.heightAnchor.constraint(equalToConstant: 45.0),
            startButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -45)
        ])
    }
    
    private func setupUi() {
        view.backgroundColor = ConstantsUi.Colors.background
        titleLabel.text = Constants.title
        paragraphLabel.text = Constants.paragraph
        startButton.setTitle(Constants.titleButton, for: .normal)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
    }
    
    @objc func startAction(sender: UIButton!) {
        coordinator?.nextScreenFaceViewController(delegate: delegate!, params: params!)
    }
}
