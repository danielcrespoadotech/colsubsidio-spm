//
//  UINavigationController+Extension.swift
//  
//
//  Created by Daniel Crespo Duarte on 25/10/22.
//

import UIKit

extension UINavigationController {
    func configurateNavigationBarAppereance() {
        self.navigationBar.shadowImage = UIImage()
        let backIcon = ConstantsUi.Images.iconBack
        self.navigationBar.backIndicatorImage = backIcon
        self.navigationBar.backIndicatorTransitionMaskImage = backIcon
        self.navigationBar.tintColor = ConstantsUi.Colors.blue
        self.navigationBar.topItem?.title = " "
        self.navigationBar.backgroundColor = .white
    }
    
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }
    
    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}
