//
//  UIActivityIndicatorView+Extension.swift
//  
//
//  Created by Daniel Crespo Duarte on 28/10/22.
//

import UIKit

extension UIActivityIndicatorView {
    func isShow(_ isShow: Bool) {
        if isShow {
            self.startAnimating()
        } else {
            self.stopAnimating()
        }
        self.isHidden = !isShow
    }
}
