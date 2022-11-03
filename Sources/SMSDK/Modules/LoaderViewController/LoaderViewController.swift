//
//  LoaderViewController.swift
//  
//
//  Created by Daniel Crespo Duarte on 31/10/22.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    
    private struct Constants {
        static let title = "Espera un momento"
        static let subTitle = "Estamos validando tu información."
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
    
    private lazy var animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView()
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        return lottieAnimationView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: ConstantsUi.Font.bold, size: 26)
        titleLabel.textColor = ConstantsUi.Colors.black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var paragraphLabel: UILabel = {
        let paragraphLabel = UILabel()
        paragraphLabel.numberOfLines = 0
        paragraphLabel.textAlignment = .left
        paragraphLabel.font = UIFont(name: ConstantsUi.Font.regular, size: 20)
        paragraphLabel.textColor = ConstantsUi.Colors.black
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        return paragraphLabel
    }()
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        return view
    }()
    
    //MARK: Initializers
    init() {
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
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            animationView.widthAnchor.constraint(equalToConstant: 75.0),
            animationView.heightAnchor.constraint(equalToConstant: 75.0),
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 35),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupUi() {
        view.backgroundColor = ConstantsUi.Colors.white
        animationView.loadAnimation(animation: .loader)
        titleLabel.text = Constants.title
        paragraphLabel.text = Constants.subTitle
        animationView.show()
    }
}
