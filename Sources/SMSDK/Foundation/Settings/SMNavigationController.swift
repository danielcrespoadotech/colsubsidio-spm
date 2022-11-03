//
//  SMNavigationController.swift
//  SMSDK
//
//  Created by Fernando León on 3/27/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

final class SMNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .clear
        navigationBar.barStyle = .default
        modalPresentationStyle = .fullScreen
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = SMColor.backgroundColor
        navigationBar.tintColor = SMColor.textColor
        navigationBar.titleTextAttributes = [.foregroundColor: SMColor.textColor, .font: UIFont.init(name: "Gilroy-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
