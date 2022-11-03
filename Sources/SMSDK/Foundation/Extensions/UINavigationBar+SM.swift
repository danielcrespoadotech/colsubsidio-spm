//
//  UINavigationBar+SM.swift
//  SMSDK
//
//  Created by Fernando León on 3/27/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}
