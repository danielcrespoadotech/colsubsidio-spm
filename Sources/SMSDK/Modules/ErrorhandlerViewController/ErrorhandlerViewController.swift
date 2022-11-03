//
//  ErrorHandlerViewController.swift
//  
//
//  Created by Daniel Crespo Duarte on 31/10/22.
//

import UIKit

protocol ErrorHandlerProtocol: AnyObject {
    func retry(type: ErrorHandlerEnum)
}

enum ErrorHandlerEnum {
    case noNetwork
    case Attemps
    case couldNotTakePhoto
    
    func getTitle() -> String {
        switch self {
        case .noNetwork:
            return "Comprueba la conexión\na internet"
        case .Attemps:
            return "¡Lo sentimos!"
        case .couldNotTakePhoto:
            return "No se pudo tomar tu foto"
        }
    }
    
    func getParagraph() -> String {
        switch self {
        case .noNetwork:
            return "Si tienes fallas en tu red, inténtalo más tarde."
        case .Attemps:
            return "Se produjo un inconveniente de comunicación, inténtalo más tarde."
        case .couldNotTakePhoto:
            return "Luego de 3 intentos fallidos, deberás acercarte a un Centro de Servicio Colsubsidio."
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .noNetwork:
            return ConstantsUi.Images.iconAttention
        case .Attemps:
            return ConstantsUi.Images.iconAttention
        case .couldNotTakePhoto:
            return ConstantsUi.Images.iconCouldNotTakePhoto
        }
    }
    
    func getTitleButton() -> String {
        switch self {
        case .noNetwork:
            return "Reintentar"
        case .Attemps:
            return "Reintentar"
        case .couldNotTakePhoto:
            return "Reintentar"
        }
    }
    
}

class ErrorHandlerViewController: UIViewController {
    
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
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
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
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        return view
    }()
    
    private lazy var retryButton: UIButton = {
        let retryButton = UIButton()
        retryButton.titleLabel?.font = UIFont(name: ConstantsUi.Font.regular, size: 20)
        retryButton.layer.cornerRadius = 6.0
        retryButton.backgroundColor = ConstantsUi.Colors.blue
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        return retryButton
    }()
    
    var errorHandler: ErrorHandlerEnum
    weak var errorHandlerProtocol: ErrorHandlerProtocol?
    
    init(errorHandler: ErrorHandlerEnum) {
        self.errorHandler = errorHandler
        super.init(nibName: nil, bundle: nil)
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
        setupIconImageView()
        setupRetryButton()
        setupStackView()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(paragraphLabel)
        stackView.addArrangedSubview(separatorView)
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
    
    private func setupIconImageView() {
        view.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 75.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 75.0),
        ])
    }
    
    private func setupRetryButton() {
        contentView.addSubview(retryButton)
        NSLayoutConstraint.activate([
            retryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            retryButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            retryButton.heightAnchor.constraint(equalToConstant: 45.0),
            retryButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 35),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 45),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -45),
            stackView.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -45)
        ])
    }
    
    private func setupUi() {
        view.backgroundColor = ConstantsUi.Colors.background
        iconImageView.image = errorHandler.getIcon()
        titleLabel.text = errorHandler.getTitle()
        paragraphLabel.text = errorHandler.getParagraph()
        retryButton.setTitle(errorHandler.getTitleButton(), for: .normal)
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
    }
    
    @objc func retryAction(sender: UIButton!) {
        errorHandlerProtocol?.retry(type: errorHandler)
        self.dismiss(animated: true, completion: nil)
    }
}
