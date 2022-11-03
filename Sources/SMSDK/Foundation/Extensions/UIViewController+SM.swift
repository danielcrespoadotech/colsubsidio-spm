//
//  UIViewController+SM.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttons: [UIAlertAction] = [UIAlertAction(title: "OK", style: UIAlertAction.Style.default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for button in buttons {
            alert.addAction(button)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertImage(title: String?, message: String?, image: UIImage) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)

        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        imgViewTitle.image = image
        alert.view.addSubview(imgViewTitle)

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    var deviceName: String {
        return UIDevice.modelName
    }
    
    func decodeBase64(toImage strEncodeData: String?) -> UIImage? {
        var strEncodeData = strEncodeData
        strEncodeData = strEncodeData?.replacingOccurrences(of: "data:image/jpg;base64,", with: "")
        let data = Data(base64Encoded: strEncodeData ?? "", options: .ignoreUnknownCharacters)
        if let data = data {
            return UIImage(data: data)
        }
        return nil
    }
}
